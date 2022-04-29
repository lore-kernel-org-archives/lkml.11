Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53707C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Apr 2022 07:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355328AbiD2H7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Apr 2022 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355298AbiD2H7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:59:30 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772D74ECF6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:56:12 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23SN7prJ028701;
        Fri, 29 Apr 2022 00:55:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=6GAf9YvYAPYD9vFjD4AGPiUOK9eXTeWscGIhp9T1sfw=;
 b=iQ2+trPdJULN+l0t53QkYp7LeOVMlosMugHwVM7WN09/YDMujFp9juTjdX5eHP6jBtF1
 KoCzDx6m8lJntUWeCEGV43DoYuVQ2l3CXB/bylYsj91frEBbKaQTvEio/r0NmIvd0JrK
 ZTNIAQw60cMvULjlYmFprSBopoEGumUdS0ID4QocKYyEoUANo7a8xH32bsKp8e1jt6RY
 Lb1oCSwNv0nZmzzdt1H/30OJaj2f2WntoL+nyhcBEs9CMsf2E3MUG/DFjNZ5KxjNawwA
 cJVDAvsTViY3thYDunSwQINjEcUzE35E4SqAMkKqGSPxapw42GOG6FKzxSIUxCILjH70 GA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3fqpvy51vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 00:55:53 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 29 Apr
 2022 00:55:51 -0700
Received: from localhost.localdomain (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Apr 2022 00:55:49 -0700
From:   Linu Cherian <lcherian@marvell.com>
To:     <maz@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuc.decode@gmail.com>,
        Linu Cherian <lcherian@marvell.com>,
        "kernel test robot" <lkp@intel.com>
Subject: [PATCH] arm64: Declare non global symbols as static
Date:   Fri, 29 Apr 2022 13:25:35 +0530
Message-ID: <20220429075535.10636-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: duzUATsxim0fRDiuye254iFtzuxZObTV
X-Proofpoint-ORIG-GUID: duzUATsxim0fRDiuye254iFtzuxZObTV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_05,2022-04-28_01,2022-02-23_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below sparse warnings introduced while adding errata.

arch/arm64/kernel/cpu_errata.c:218:25: sparse: warning: symbol
'cavium_erratum_23154_cpus' was not declared. Should it be static?
arch/arm64/kernel/cpu_errata.c:233:25: sparse: warning: symbol
'cavium_erratum_27456_cpus' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
 arch/arm64/kernel/cpu_errata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 4c9b5b4b7a0b..57a39cb6b489 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -215,7 +215,7 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
 #endif
 
 #ifdef CONFIG_CAVIUM_ERRATUM_23154
-const struct midr_range cavium_erratum_23154_cpus[] = {
+static const struct midr_range cavium_erratum_23154_cpus[] = {
 	MIDR_ALL_VERSIONS(MIDR_THUNDERX),
 	MIDR_ALL_VERSIONS(MIDR_THUNDERX_81XX),
 	MIDR_ALL_VERSIONS(MIDR_THUNDERX_83XX),
@@ -230,7 +230,7 @@ const struct midr_range cavium_erratum_23154_cpus[] = {
 #endif
 
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
-const struct midr_range cavium_erratum_27456_cpus[] = {
+static const struct midr_range cavium_erratum_27456_cpus[] = {
 	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
 	MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
 	/* Cavium ThunderX, T81 pass 1.0 */
-- 
2.31.1

