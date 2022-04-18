Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EBCC41535
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 13:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244148AbiDRNn1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 09:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241766AbiDRNQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F9F3B2A4;
        Mon, 18 Apr 2022 05:51:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 081066124E;
        Mon, 18 Apr 2022 12:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFF0C385A1;
        Mon, 18 Apr 2022 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650286286;
        bh=ougz0A3GVQnfqTBVPOaUoq+OCwWMjMUSH082GbCyOXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Otd9kC6fR/nTvGvsSrXTxvAuQqMCU+a53EFhfqI2VgkeHJqloNkhGPlAxxAke74FT
         8O484v+WPeIC1AYciCNpOWGYy5ymSusTommMurPoIjRZjH0mmM/0NNST+W0RVuhzng
         DrPswGRgKrTkNoTTROU5TVft+ct+aVM/NBxE5y0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 046/284] thermal: int340x: Increase bitmap size
Date:   Mon, 18 Apr 2022 14:10:27 +0200
Message-Id: <20220418121212.005004311@linuxfoundation.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418121210.689577360@linuxfoundation.org>
References: <20220418121210.689577360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit 668f69a5f863b877bc3ae129efe9a80b6f055141 upstream.

The number of policies are 10, so can't be supported by the bitmap size
of u8.

Even though there are no platfoms with these many policies, but
for correctness increase to u32.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: 16fc8eca1975 ("thermal/int340x_thermal: Add additional UUIDs")
Cc: 5.1+ <stable@vger.kernel.org> # 5.1+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -53,7 +53,7 @@ struct int3400_thermal_priv {
 	struct art *arts;
 	int trt_count;
 	struct trt *trts;
-	u8 uuid_bitmap;
+	u32 uuid_bitmap;
 	int rel_misc_dev_res;
 	int current_uuid_index;
 };


