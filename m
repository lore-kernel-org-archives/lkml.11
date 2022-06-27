Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCA9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiF0LZj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbiF0LZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:25:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE30C65A5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:25:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 65so8691435pfw.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXn3wWbVxQI6jCo/9N11UZ5IVbNzRYO/KcWY9DeSESE=;
        b=YnPlXzKkEPch/sWHvGKsHeXpd88h+buPua0eN4oyDaqM34DNBm0PGwC+tZGTzDadAh
         8Wr4EbkdVWgOXhwf9B9sm20t0EpfN6y1ybvTGdiQLTO4MaIgo+ruM/RZ3UNuEaqt4yfk
         FvtJA6z6WkBX3v0VX40F+SeECrOgZaRAAtYfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXn3wWbVxQI6jCo/9N11UZ5IVbNzRYO/KcWY9DeSESE=;
        b=G+0sjPRZPQr/6V+0U74YdbKOGEJ2QnEmBQDQ6ofQqOk90L7t4oTKSnVsPdycVRdC6x
         t05AZu0UnUtPKsnvlgnM9mkrvo59pAgQCiyKV0Ky2yKw1xUDS7fqg2aZ8zGB1I3VgQzC
         QKVwS/hLtqA8SV+gdXoBnyIGFQ68tMqFRBTBMG6wycaguyeAU+l9eG8omV5EBP3lckL5
         ozi/KluYSIXTFRYPhwgaaG71DmTylpl+NHH0L7JAT0KYjmBXF84y0l0nAFwm3ZfWgzKa
         N5/TuCPje/nyB1DFk8oo9WDA4AJYIHi7zOs2cSt0adnFNc4A3MiuTXYEF00eOzFxSXcC
         8vuQ==
X-Gm-Message-State: AJIora9XGWCmLYv7Nnq38rYxvwT39KWepysUrVIOPWu7xORDWHKz/bVC
        0/c7KMKHkz77Cyy9i9mRhB0mXg==
X-Google-Smtp-Source: AGRyM1vaMaOkFM2pCPF4KFwOkt5DhQveHKus1rkl2C7vQO6ZDwtPdPvhygvlqcvYA0FYizMxom86mQ==
X-Received: by 2002:a05:6a00:2187:b0:50c:ef4d:ef3b with SMTP id h7-20020a056a00218700b0050cef4def3bmr14510434pfi.83.1656329100033;
        Mon, 27 Jun 2022 04:25:00 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2dc1:c31b:b5ed:f3aa])
        by smtp.gmail.com with ESMTPSA id lj4-20020a17090b344400b001ece32cbec9sm9246889pjb.24.2022.06.27.04.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:24:59 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Subject: [PATCH 1/4] media: mediatek: vcodec: dec: Fix 4K frame size enumeration
Date:   Mon, 27 Jun 2022 19:23:59 +0800
Message-Id: <20220627112402.2332046-2-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220627112402.2332046-1-wenst@chromium.org>
References: <20220627112402.2332046-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This partially reverts commit b018be06f3c7 ("media: mediatek: vcodec:
Read max resolution from dec_capability"). In this commit, the maximum
resolution ended up being a function of both the firmware capability and
the current set format.

However, frame size enumeration for output (coded) formats should not
depend on the format set, but should return supported resolutions for
the format requested by userspace.

Fix this so that the driver returns the supported resolutions correctly,
even if the instance only has default settings, or if the output format
is currently set to VP8F, which does not support 4K.

Fixes: b018be06f3c7 ("media: mediatek: vcodec: Read max resolution from dec_capability")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c    | 2 --
 .../platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c    | 7 +++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 5d6fdf18c3a6..fcb4b8131c49 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -595,8 +595,6 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 		fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
 		fsize->stepwise = dec_pdata->vdec_framesizes[i].stepwise;
 
-		fsize->stepwise.max_width = ctx->max_width;
-		fsize->stepwise.max_height = ctx->max_height;
 		mtk_v4l2_debug(1, "%x, %d %d %d %d %d %d",
 				ctx->dev->dec_capability,
 				fsize->stepwise.min_width,
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
index 16d55785d84b..9a4d3e3658aa 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
@@ -360,6 +360,13 @@ static void mtk_vcodec_add_formats(unsigned int fourcc,
 
 		mtk_vdec_framesizes[count_framesizes].fourcc = fourcc;
 		mtk_vdec_framesizes[count_framesizes].stepwise = stepwise_fhd;
+		if (!(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED) &&
+		    fourcc != V4L2_PIX_FMT_VP8_FRAME) {
+			mtk_vdec_framesizes[count_framesizes].stepwise.max_width =
+				VCODEC_DEC_4K_CODED_WIDTH;
+			mtk_vdec_framesizes[count_framesizes].stepwise.max_height =
+				VCODEC_DEC_4K_CODED_HEIGHT;
+		}
 		num_framesizes++;
 		break;
 	case V4L2_PIX_FMT_MM21:
-- 
2.37.0.rc0.161.g10f37bed90-goog

