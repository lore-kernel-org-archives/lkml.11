Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB6AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 00:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbiCKA6u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 19:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiCKA6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:58:48 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17812C621F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646960267; x=1678496267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fROPMJ0aWjZeKi8CMmgQhx4a+oSgNaOrWlO2neoVxFA=;
  b=cpHATCh3YAs+HtwdxlTxm87mvNZceLT4T6LVgDrVc97VoVt1zgp2n9+w
   RuLmUddlfjxLZ6hq6dy/eMR4BwKlIiqeEiQzC7LzQ1HC0spxuH4TRFcAE
   Aic55LbCOYSDMf1Zh+ZxhWJXgNk/BEWzich8czH4zRBSo7AXPlErAIj82
   JWDhB2t39MKbMOzGdVcysCAa44HiOoAVe2ApnS+qqxQC3Q82+T1ErJ83C
   asJsj5eObAEU7hbZf9RFjY3SioaOC/oVU1gr7weE0/uGytyMJA8al7h3M
   9SYq2VXUMnP41B13hl6GegVTaV7fL9viJxfR+CqzbgxwzchesZpOOTpWG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255191291"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="255191291"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 16:57:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="579064522"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 16:57:44 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Pkey User clean up patches
Date:   Thu, 10 Mar 2022 16:57:37 -0800
Message-Id: <20220311005742.1060992-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

I'm looking for acks that this is acceptable for official submission to the
maintainers.  I believe the code to be better than RFC quality but I realize
that the type changes may be more churn than is desired.

The following patches contain pkey cleanups and an attempt to standardize on
the type used for pkeys.

The PKS code is standardizing on u8 for the pkey type and for some of the call
paths in the user space code this should work as well.

Ira Weiny (5):
x86/pkeys: Clean up arch_set_user_pkey_access() declaration
x86/pkeys: Remove __arch_set_user_pkey_access() declaration
powerpc/pkeys: Properly type pkey in init_{i}amr()
mm/pkeys: Make pkey unsigned in arch_set_user_pkey_access()
x86/pkeys: Standardize on u8 for pkey type

arch/powerpc/include/asm/pkeys.h | 4 ++--
arch/powerpc/mm/book3s64/pkeys.c | 6 +++---
arch/x86/include/asm/pgtable.h | 4 ++--
arch/x86/include/asm/pkeys.h | 12 ++----------
arch/x86/include/asm/pkru.h | 4 ++--
arch/x86/kernel/fpu/xstate.c | 2 +-
include/linux/pkeys.h | 2 +-
7 files changed, 13 insertions(+), 21 deletions(-)

--
2.35.1

