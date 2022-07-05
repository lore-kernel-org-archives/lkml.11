Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904DECCA488
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 12:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbiGEMfR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 08:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiGEM0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:26:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE456183BC;
        Tue,  5 Jul 2022 05:18:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E497619A6;
        Tue,  5 Jul 2022 12:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F45C341C7;
        Tue,  5 Jul 2022 12:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657023518;
        bh=5x5kfHb/YFMwxL5zWAPdXhpL4OhMDYPtuWCt/60+ydo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5npsJcvAGL8+zqWFTuTSRYNutRVBDlDokeHi/sDIgb3J6M4jL9AczazdJpW/1lnH
         JQ1njFoGaAdpfhGCGsqJ/wdNtN55AL+WEgE1PCyltUEFop3r9AQaDy4cVPEnbKlSPj
         A+wG3u7bfj3A7b5g0iZC4NRqDHd5BvBNnbISzyHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Stefan Seyfried <seife+kernel@b1-systems.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: [PATCH 5.18 090/102] platform/x86: panasonic-laptop: revert "Resolve hotkey double trigger bug"
Date:   Tue,  5 Jul 2022 13:58:56 +0200
Message-Id: <20220705115620.976380132@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705115618.410217782@linuxfoundation.org>
References: <20220705115618.410217782@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 83a5ddc3dc561c40d948b85553514aaba99123d8 ]

In hindsight blindly throwing away most of the key-press events is not
a good idea. So revert commit ed83c9171829 ("platform/x86:
panasonic-laptop: Resolve hotkey double trigger bug").

Fixes: ed83c9171829 ("platform/x86: panasonic-laptop: Resolve hotkey double trigger bug")
Reported-and-tested-by: Stefan Seyfried <seife+kernel@b1-systems.com>
Reported-and-tested-by: Kenneth Chan <kenneth.t.chan@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20220624112340.10130-5-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/panasonic-laptop.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 26e31ac09dc6..2e6531dd15f9 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -783,12 +783,8 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 					key, 0x80, false);
 	}
 
-	/* for the magic values, see panasonic_keymap[] above */
-	if (key == 7 || key == 9 || key == 10) {
-		if (!sparse_keymap_report_event(hotk_input_dev,
-						key, updown, false))
-			pr_err("Unknown hotkey event: 0x%04llx\n", result);
-	}
+	if (!sparse_keymap_report_event(hotk_input_dev, key, updown, false))
+		pr_err("Unknown hotkey event: 0x%04llx\n", result);
 }
 
 static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
-- 
2.35.1



