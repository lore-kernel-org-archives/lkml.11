Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81840C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 10:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355218AbiHWKfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354192AbiHWKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:20:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAFAAD;
        Tue, 23 Aug 2022 02:02:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C862E61579;
        Tue, 23 Aug 2022 09:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B26BC433C1;
        Tue, 23 Aug 2022 09:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661245336;
        bh=B+3p/GQqQOtvQA60D7Hg3pIgqOkJKFL3MaPiyOP8loE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kNN63geELsPNlG9YOK6/u5UmBGmGtVW/n1lcSHvjncTwECpSDo0Muom3f8quqJNWs
         CiC/DFIorbdCJBRpNboA0laNdTR3PsZ1aMqnI7odBDeF+wbxvn7Bil1bPSKRHE4kQ2
         xjq4ihtgjmx3XR9GTdQV9rV4XfzuR8TRVVT9KfL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 047/287] ACPI: EC: Remove duplicate ThinkPad X1 Carbon 6th entry from DMI quirks
Date:   Tue, 23 Aug 2022 10:23:36 +0200
Message-Id: <20220823080101.840676854@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080100.268827165@linuxfoundation.org>
References: <20220823080100.268827165@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 0dd6db359e5f206cbf1dd1fd40dd211588cd2725 ]

Somehow the "ThinkPad X1 Carbon 6th" entry ended up twice in the
struct dmi_system_id acpi_ec_no_wakeup[] array. Remove one of
the entries.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e3df3dda0332..3394ec64fe95 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2118,13 +2118,6 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "Thinkpad X1 Carbon 6th"),
 		},
 	},
-	{
-		.ident = "ThinkPad X1 Carbon 6th",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Carbon 6th"),
-		},
-	},
 	{
 		.ident = "ThinkPad X1 Yoga 3rd",
 		.matches = {
-- 
2.35.1



