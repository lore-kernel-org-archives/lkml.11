Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95824C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 15:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356365AbiDNPSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 11:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347174AbiDNN6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:58:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE8FB8201;
        Thu, 14 Apr 2022 06:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C680CCE296C;
        Thu, 14 Apr 2022 13:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCDDC385A1;
        Thu, 14 Apr 2022 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649944143;
        bh=jqoTXhbCE8f9VVEPdQmbBZ+ZZAm2sOJZf2jH0X2ySo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wQX/MGRPc/xnTbMCqSh0C+LPdb0zkvYvzn0CKjhzN7Iphur6kYauUa6m/GjdPTR2G
         QZ2R0xAGkKcqhySXX0tp/PIZ+9wjmwvMegreiF7dWLPUa6aB2+8df8CGw2tQ07Sm9i
         dDiYWYig8hFfG6k1gqIeLSFqClT52LSisaXSczWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 392/475] drm/amdkfd: make CRAT table missing message informational only
Date:   Thu, 14 Apr 2022 15:12:57 +0200
Message-Id: <20220414110906.042330009@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110855.141582785@linuxfoundation.org>
References: <20220414110855.141582785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 9dff13f9edf755a15f6507874185a3290c1ae8bb ]

The driver has a fallback so make the message informational
rather than a warning. The driver has a fallback if the
Component Resource Association Table (CRAT) is missing, so
make this informational now.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1906
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 66387caf966e..3685e89415d5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -758,7 +758,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 	/* Fetch the CRAT table from ACPI */
 	status = acpi_get_table(CRAT_SIGNATURE, 0, &crat_table);
 	if (status == AE_NOT_FOUND) {
-		pr_warn("CRAT table not found\n");
+		pr_info("CRAT table not found\n");
 		return -ENODATA;
 	} else if (ACPI_FAILURE(status)) {
 		const char *err = acpi_format_exception(status);
-- 
2.35.1



