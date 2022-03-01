Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DA3C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 20:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiCAUcU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbiCAUcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:32:08 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B059E9C6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646166592; x=1677702592;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pwbnZ7nqDFIvv/c4BSkAveh+9Y+Gghfcais2Rp9Mvyg=;
  b=bOAVPwoGtcVVD5kY7p72PP08Zr8vEkHw4HxpOtKX8FYFymfsivd1Aeey
   ItujT/FAy5X6cmZo/k3Kx62KGSVCRS9Tq6I4WTew+OfNFQBRkqlzsTb95
   TvPPSFR9IJF3EWk3OiY8pBjKA5s4Q6r78Cp7F2vvd6hc9NguLH5v9T8L3
   o=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 01 Mar 2022 12:29:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 12:29:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Mar 2022 12:29:51 -0800
Received: from ubuntu.qualcomm.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 1 Mar 2022
 12:29:50 -0800
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] configs/debug: set CONFIG_DEBUG_INFO=y properly
Date:   Tue, 1 Mar 2022 15:29:20 -0500
Message-ID: <20220301202920.18488-1-quic_qiancai@quicinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_INFO can't be set by user directly, so set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y instead. Otherwise, we end
up with no debuginfo in vmlinux which is a big no-no for kernel
debugging.

Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
---
 kernel/configs/debug.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index e9ffb0cc1eec..07df6d93c4df 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -16,7 +16,7 @@ CONFIG_SYMBOLIC_ERRNAME=y
 #
 # Compile-time checks and compiler options
 #
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_FRAME_WARN=2048
 CONFIG_SECTION_MISMATCH_WARN_ONLY=y
-- 
2.30.2

