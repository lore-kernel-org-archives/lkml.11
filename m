Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23423C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jul 2022 07:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiGXHSz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jul 2022 03:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbiGXHSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:18:53 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880F618B20
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 00:18:48 -0700 (PDT)
X-QQ-mid: bizesmtp80t1658647117t7pjan0r
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:18:36 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: /rrU+puPB7TjkaUBztrLltq+wkA0e+Bb8w1SMyQjfVFqByq7dJyeckZRfXepg
        U4kMJIbsgKBCSxvyN4N7MfPy/TrwOMfyTX0u00GjabR6AnPtnJGlWb2Op7GkGbXw5zASVHA
        rBSSv36lgJWoZHtkl4rfEW7fOSpgfp1EcLnvGeBvtzSiOtfyCMLNpxP0ebtm334bRwoHD/V
        JfeWQ+I4WAg9joN5yVmkPwwMcI2niEzgDgJPJI6Zgct66AQqmEAKvLtHm/ocWm6Qa3yAjf7
        XMDO0R9fjs2u06UodpdBN5pzt4b5xW4eFzuXJLduFJCg4fQqv6PfFb6ulTN0nQA51Yq5ddV
        KVPWxiSeeLGQNGzufyRqwC8Ko4NaMVi0b7+Rex0Rvgqily7cUM=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] usb/hiface: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:18:29 +0800
Message-Id: <20220724071829.11117-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 sound/usb/hiface/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index 71f17f02f341..cf650fab54d7 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -225,7 +225,7 @@ static int hiface_pcm_stream_start(struct pcm_runtime *rt)
 			}
 		}
 
-		/* wait for first out urb to return (sent in in urb handler) */
+		/* wait for first out urb to return (sent in urb handler) */
 		wait_event_timeout(rt->stream_wait_queue, rt->stream_wait_cond,
 				   HZ);
 		if (rt->stream_wait_cond) {
-- 
2.36.1

