; (function (global) {

    var fabric = global.fabric;

    // dependancy not met
    if (!fabric) {
        return;
    }

    var getRandomInt = fabric.util.getRandomInt;

    fabric.SquareBrush = fabric.util.createClass(fabric.BaseBrush, {

        /**
         * Width of the brush
         * @type {Number}
         */
        width: 10,

        /**
         * Constructor
         * @param {fabric.Canvas} canvas
         * @return {fabric.RectBrush} Instance of a circle brush
         */
        initialize: function (canvas) {
            this.canvas = canvas;
            this.points = [];
        },
        /**
         * Invoked inside on mouse down and mouse move
         * @param {Object} pointer
         */
        drawDot: function(pointer) {
            var point = this.addPoint(pointer),
                ctx = this.canvas.contextTop;
            this._saveAndTransform(ctx);
            this.dot(ctx, point);
            ctx.restore();
        },

        dot: function(ctx, point) {
            ctx.fillStyle = point.fill;
            ctx.beginPath();
            ctx.fillRect(point.x - point.width / 2, point.y - point.height / 2, point.width, point.height);            ctx.closePath();
            ctx.closePath();
            ctx.fill();
        },


        /**
         * Invoked on mouse down
         * @param {Object} pointer
         */
        onMouseDown: function (pointer) {
            this.points.length = 0;
            this.canvas.clearContext(this.canvas.contextTop);
            this._setShadow();
            this.drawDot(pointer);
        },

        /**
         * Render the full state of the brush
         * @private
         */
        _render: function() {
            var ctx  = this.canvas.contextTop, i, len,
                points = this.points;
            this._saveAndTransform(ctx);
            for (i = 0, len = points.length; i < len; i++) {
                this.dot(ctx, points[i]);
            }
            ctx.restore();
        },

        /**
         * Invoked on mouse move
         * @param {Object} pointer
         */
        onMouseMove: function (pointer) {
            if (this.needsFullRender()) {
                this.canvas.clearContext(this.canvas.contextTop);
                this.addPoint(pointer);
                this._render();
            }
            else {
                this.drawDot(pointer);
            }
        },

        /**
         * Invoked on mouse up
         */
        onMouseUp: function () {
            var originalRenderOnAddRemove = this.canvas.renderOnAddRemove;
            this.canvas.renderOnAddRemove = false;

            var rects = [];

            for (var i = 0, len = this.points.length; i < len; i++) {
                var point = this.points[i];
                var rect = new fabric.Rect({
                    width: point.width,
                    height: point.height,
                    top: point.y,
                    left: point.x,
                    originX: 'center',
                    originY: 'center',
                    fill: point.fill
                });

                this.shadow && (rect.shadow = new fabric.Shadow(this.shadow));

                rects.push(rect);
            }
            var group = new fabric.Group(rects);
            group.canvas = this.canvas;
            this.canvas.fire('brefore:path:created', {path: group});
            this.canvas.add(group);
            this.canvas.fire('path:created', {path:group});

            this.canvas.clearContext(this.canvas.contextTop);
            this._resetShadow();
            this.canvas.renderOnAddRemove = originalRenderOnAddRemove;
            this.canvas.requestRenderAll();
        },

        addPoint: function (pointer) {
            var pointerPoint = new fabric.Point(pointer.x, pointer.y),
                width = getRandomInt(0, this.width),
                color = new fabric.Color(this.color)
                    .setAlpha(fabric.util.getRandomInt(0, 100) / 100)
                    .toRgba();

            pointerPoint.width = pointerPoint.height = width;
            pointerPoint.fill = color;

            this.points.push(pointerPoint);
            return pointerPoint;
        }
    });

})(this);