Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD648C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 15:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347852AbiCHPhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 10:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242096AbiCHPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:37:10 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A70437A9E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646753774; x=1678289774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ef9R2b/Ju/qZPrrxyWZA84GKWq/hmsuG1yMQAEFArhQ=;
  b=EQKw8ZDgDwbOjaDeSQL1hXvynBY/judbTTBWtTCMyHxwdifxxHnwIwxJ
   PPha1DwaCKvJHnOeXW11C4FVW/fAhr07K2fb6TTpohfHe6aJeT/GamcRO
   kNRLiOSgly8Wu4jnDeOoRdW8noHHk1NFFm8ryaBzITNox/fEyjz8XHQnr
   Y=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 08 Mar 2022 07:36:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 07:36:14 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Mar 2022 07:36:13 -0800
Received: from ubuntu.qualcomm.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 8 Mar 2022
 07:36:13 -0800
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH] configs/debug: Restore DEBUG_INFO=y for overriding
Date:   Tue, 8 Mar 2022 10:35:24 -0500
Message-ID: <20220308153524.8618-1-quic_qiancai@quicinc.com>
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

Previously, I failed to realize that Kees' patch [1] has not been merged
into the mainline yet, and dropped DEBUG_INFO=y too eagerly from the
mainline. As the results, "make debug.config" won't be able to flip
DEBUG_INFO=n from the existing .config. This should close the gaps of a
few weeks before Kees' patch is there, and work regardless of their
merging status anyway.

[1] https://lore.kernel.org/all/20220125075126.891825-1-keescook@chromium.org/

Reported-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
---
 kernel/configs/debug.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index 07df6d93c4df..e8db8d938661 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -16,6 +16,7 @@ CONFIG_SYMBOLIC_ERRNAME=y
 #
 # Compile-time checks and compiler options
 #
+CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_FRAME_WARN=2048
-- 
2.30.2

