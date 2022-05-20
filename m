Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A59C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 03:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbiETDN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 23:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiETDNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:13:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875EF149DA6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653016417; x=1684552417;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AOGe5WBFDH67nOrGeCJ89LRrakHSBnpfhodZrhPsQeE=;
  b=CzEREJMTRY/6MzET3luy7dtroeFgNmbFQvX8uF8g+HF80jqVC1HbCH0S
   I6ww36i7W6qdKULhCYR5zA4rlKgodiOYzIbvwe+XY9qad+CVm25iQ//47
   ueTcAHL4WBgzJh1/wOSrS1+RQO2gE82JTUBmc1tBmYl5n1KMxnTFqyEeN
   uIKmD+65UeKSQNDIH7yrp3+6zhuHmerZRQR15B/wdcfrs88u35w/JmKeJ
   vXaLmUiu47PDKfajjyEfGKyX8dradH611OvRvi+sV6wR9W397gAPLu5bn
   wS+a0tbiMjqcefMZZwNJ9ekGPUTz+oIWSgHKTSKPqp0ZNU+5/mD0xqDk5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="335517345"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="335517345"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 20:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="818318763"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 May 2022 20:13:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id DD786109; Fri, 20 May 2022 06:13:24 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 0/3] Fix for load_unaligned_zeropad() in TDX guest
Date:   Fri, 20 May 2022 06:13:13 +0300
Message-Id: <20220520031316.47722-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An updated version of the load_unaligned_zeropad() fix.

v2:
 - Clarify RIP adjustments during #VE handling;
 - Fix early #VE handling;
 - Fix comment and commit message;

Kirill A. Shutemov (3):
  x86/tdx: Fix early #VE handling
  x86/tdx: Clarify RIP adjustments in #VE handler
  x86/tdx: Handle load_unaligned_zeropad() page-cross to a shared page

 arch/x86/coco/tdx/tdx.c | 166 +++++++++++++++++++++++++++-------------
 1 file changed, 113 insertions(+), 53 deletions(-)

-- 
2.35.1

