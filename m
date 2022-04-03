Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5B3C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 22:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376569AbiDCW3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 18:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356307AbiDCW3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 18:29:51 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 297B339832
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 15:27:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1649024875; h=Content-Transfer-Encoding: MIME-Version:
 Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To: From: From:
 Sender: Sender; bh=y5ltD1YbS8stWfMw6OYDAa9OeNCMcSjpNZgM56D6GYk=; b=cluZAkN45jbekEjJJyOa2ggjeaCcx4RjlXjAWENfcB7O9HfnxQJ+sg54NEwa4jL3CctHax8+
 PNJWk8VsAD2uq0mohzlJjAEV/qMgN7/uyQUi7j51HMAwKjlRMFn3tL6AJ22i5Sy29oW83Ec1
 A/l8t2qRBHQtJxv1Ot/SFBt/fivD7bigjLCmNwsdP13FmZcQwFU+oVe4IhmoNo2EWv/IwPZV
 Inn8leZAv7jJEypQ3YyPnajcfaaLaZmMTiBogN2fFZktEgd0eATD8H460h41FBc0xtIhF6QL
 j9lle7jDxQ8v7VnBQQ+VPxOUa/s4RR7K4gX9bJb8mSNiMSq4Uy1qOg==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from localhost.localdomain (177.75.142.174.mhnet.com.br
 [177.75.142.174]) by smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 624a1f5ccb3e04acafb2af83 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Sun, 03 Apr 2022 22:27:40 GMT
Sender: codeagain@codeagain.dev
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Cc:     Bruno Moreira-Guedes <codeagain@codeagain.dev>
Subject: [PATCH] staging: vme_user: Fixed typo in the MODULE_AUTHOR
Date:   Sun,  3 Apr 2022 19:27:28 -0300
Message-Id: <20220403222728.276111-1-codeagain@codeagain.dev>
X-Mailer: git-send-email 2.35.1
Reply-To: Bruno's Patch Box <patch-reply@codeagain.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_AUTHOR line missed the '>' character in the end of the
author's e-mail address. Just added it.

Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
---
 drivers/staging/vme/devices/vme_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme/devices/vme_user.c b/drivers/staging/vme/devices/vme_user.c
index e3fa38bd7f12..859af797630c 100644
--- a/drivers/staging/vme/devices/vme_user.c
+++ b/drivers/staging/vme/devices/vme_user.c
@@ -773,7 +773,7 @@ MODULE_PARM_DESC(bus, "Enumeration of VMEbus to which the driver is connected");
 module_param_array(bus, int, &bus_num, 0000);
 
 MODULE_DESCRIPTION("VME User Space Access Driver");
-MODULE_AUTHOR("Martyn Welch <martyn.welch@ge.com");
+MODULE_AUTHOR("Martyn Welch <martyn.welch@ge.com>");
 MODULE_LICENSE("GPL");
 
 module_init(vme_user_init);
-- 
2.35.1

