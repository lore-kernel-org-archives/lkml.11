Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807CDC4167B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiDEMzF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243706AbiDEJPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:15:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651FC939F6;
        Tue,  5 Apr 2022 02:01:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AA47B81A12;
        Tue,  5 Apr 2022 09:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D7EC385A1;
        Tue,  5 Apr 2022 09:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649149283;
        bh=MMP6k/LNUR1jVifTaiPGoAePLM2M7XdwQlkDS3TOkuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lR2yM8molgt48rX8ykBsenQ7pjbqBtrSVDDHQ8soi7+WmXvhPsyI+vg/CWMaEy7dM
         5QqfRJdlulIzg8Wi4EUdR+5EDPyhqoMsDUYSBOZb9cDddoZF1kXuQgBypuzLUOxMyK
         PBNS1z/zVpLnvQ/s+5CykpK92mFhYrkfl4f2EhtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0659/1017] staging:iio:adc:ad7280a: Fix handing of device address bit reversing.
Date:   Tue,  5 Apr 2022 09:26:12 +0200
Message-Id: <20220405070413.843905470@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit f281e4ddbbc0b60f061bc18a2834e9363ba85f9f ]

The bit reversal was wrong for bits 1 and 3 of the 5 bits.
Result is driver failure to probe if you have more than 2 daisy-chained
devices.  Discovered via QEMU based device emulation.

Fixes tag is for when this moved from a macro to a function, but it
was broken before that.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: 065a7c0b1fec ("Staging: iio: adc: ad7280a.c: Fixed Macro argument reuse")
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Link: https://lore.kernel.org/r/20220206190328.333093-2-jic23@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index fef0055b8990..20183b2ea127 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -107,9 +107,9 @@
 static unsigned int ad7280a_devaddr(unsigned int addr)
 {
 	return ((addr & 0x1) << 4) |
-	       ((addr & 0x2) << 3) |
+	       ((addr & 0x2) << 2) |
 	       (addr & 0x4) |
-	       ((addr & 0x8) >> 3) |
+	       ((addr & 0x8) >> 2) |
 	       ((addr & 0x10) >> 4);
 }
 
-- 
2.34.1



