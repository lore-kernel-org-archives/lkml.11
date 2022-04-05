Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8FFC35296
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiDEIm0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiDEH5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:57:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE42F4F472;
        Tue,  5 Apr 2022 00:51:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E710AB81B90;
        Tue,  5 Apr 2022 07:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6E4C340EE;
        Tue,  5 Apr 2022 07:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649145077;
        bh=8WUcXf2fydo71lvratLNwZm79PRHYkwykZxleLtYYIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FY22G63s3XhtVkYVAZ3GJHt/mPWLO9FB4nrxxq9sQ50IhGRAjjoTdRKydVFDO1lQa
         qK48D7UJMd4tm2kQwTag1l1RtqvYoqaHx1Yx98bJPMovNChXYdmbadFNZnFiPpbv2a
         F9MvyI7TCXg44491cY5exC5hwWHO9FRgRbTG38Gk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0259/1126] crypto: qat - fix initialization of pfvf cap_msg structures
Date:   Tue,  5 Apr 2022 09:16:46 +0200
Message-Id: <20220405070415.213136224@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 54584146cc8cb49ce471011d4afcc03a8a529463 ]

Initialize fully the structures cap_msg containing the device
capabilities from the host.

This is to fix the following warning when compiling the QAT driver
using the clang compiler with CC=clang W=2:

    drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c:99:44: warning: missing field 'ext_dc_caps' initializer [-Wmissing-field-initializers]
            struct capabilities_v3 cap_msg = { { 0 }, };
                                                      ^

Fixes: 851ed498dba1 ("crypto: qat - exchange device capabilities over PFVF")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c b/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c
index 14b222691c9c..c5b326f63e95 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c
@@ -96,7 +96,7 @@ int adf_vf2pf_request_version(struct adf_accel_dev *accel_dev)
 int adf_vf2pf_get_capabilities(struct adf_accel_dev *accel_dev)
 {
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	struct capabilities_v3 cap_msg = { { 0 }, };
+	struct capabilities_v3 cap_msg = { 0 };
 	unsigned int len = sizeof(cap_msg);
 
 	if (accel_dev->vf.pf_compat_ver < ADF_PFVF_COMPAT_CAPABILITIES)
-- 
2.34.1



