Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A600C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 13:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiDNNXM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 09:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244042AbiDNNUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:20:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F402D9286F;
        Thu, 14 Apr 2022 06:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87F55B82983;
        Thu, 14 Apr 2022 13:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D35C385A5;
        Thu, 14 Apr 2022 13:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649942227;
        bh=ougz0A3GVQnfqTBVPOaUoq+OCwWMjMUSH082GbCyOXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdnAxUkVC3RdBRrl4yfKF5YawPLrTMA8aBT2DhMFLovyzKPKUVEGdS0Bn4EiQMtfw
         zEPw5YaacuQdFe9YAk2ig/ZgkXaenKuLTbjx318T8i9pu56292wWEYCL5wZOIC8Y28
         DAaK06c7sIuZDHlj7PfpH6iNrYWFOPI5kzuPp3jo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.19 059/338] thermal: int340x: Increase bitmap size
Date:   Thu, 14 Apr 2022 15:09:22 +0200
Message-Id: <20220414110840.577494037@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110838.883074566@linuxfoundation.org>
References: <20220414110838.883074566@linuxfoundation.org>
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


