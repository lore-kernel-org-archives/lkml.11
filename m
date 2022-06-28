Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A12C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 09:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbiF1JsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344328AbiF1Jqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:46:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1952A25C68;
        Tue, 28 Jun 2022 02:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B22A2B81D99;
        Tue, 28 Jun 2022 09:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599F9C341E4;
        Tue, 28 Jun 2022 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656409590;
        bh=iaQdNc88ElygWwpOBXidr0c6SZkvYula3SyEYHKlyDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+A91k9QbTLFzrmkI3RA2LnkHMLtZfcQO9njDmN3DctNkjWrqagq+CmvGs8WYGbpZ
         m/7ldVT+IG1AQq0oS6cBVmvYlg9QbCTUUbjxItk3WS0ZBDTLqYCDBe4ENl0I5zFLdT
         aQU+nQH2TiOz9PWkRAEHYt+DLyV8YJYWQ9xMkAGkG/zbVyDJy6H488gAkK/zON4Qf5
         GDo9okXLAvXrupP8UoeGtu9f39bEHhXm4GSOcFMzMXar+pTxSi4K7esbzrscu/d48q
         YMAyji5yDkB9NVj4Of1MlqGZ5LbmqMXl9i/p3uL9LuFyEJurX25dcd4xHFRQumV3qA
         FmOdClokY4UPw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o67ng-005HFu-1W;
        Tue, 28 Jun 2022 10:46:28 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 21/22] usb: dwc3: document async_callbacks field
Date:   Tue, 28 Jun 2022 10:46:25 +0100
Message-Id: <2c3de5935934baec097286f525ce4beff0a31ec0.1656409369.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656409369.git.mchehab@kernel.org>
References: <cover.1656409369.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a kernel-doc warning by documenting it:
	drivers/usb/dwc3/core.h:1328: warning: Function parameter or member 'async_callbacks' not described in 'dwc3'

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/

 drivers/usb/dwc3/core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 722808d8c0af..4fe4287dc934 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1087,6 +1087,8 @@ struct dwc3_scratchpad_array {
  * @dis_u1_entry_quirk: set if link entering into U1 state needs to be disabled.
  * @dis_u2_entry_quirk: set if link entering into U2 state needs to be disabled.
  * @dis_rxdet_inp3_quirk: set if we disable Rx.Detect in P3
+ * @async_callbacks: if set, indicate that async callbacks will be used.
+ *
  * @dis_u2_freeclk_exists_quirk : set if we clear u2_freeclk_exists
  *			in GUSB2PHYCFG, specify that USB2 PHY doesn't
  *			provide a free-running PHY clock.
-- 
2.36.1

