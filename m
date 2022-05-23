Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FB2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 17:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242419AbiEWRpr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 13:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbiEWR2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:28:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A38A8CCF6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653326676; x=1684862676;
  h=message-id:date:mime-version:from:subject:cc:to:
   content-transfer-encoding;
  bh=yYasMBXt5ymnR6k+hI8pCXBx+rUativPdyCsLhPKcWs=;
  b=XrEUwLZyinpZ2MVn78OKo5Rw4t1qXYDJFr4xiT9k/uPyZGniXs74UmHj
   ntI81Mk41vYD7PE7z0AcrUWRBggb0b6TLiM9Kmsj5wqLpwk5EP65zA6y0
   xoss4R04gd1622IjxkVS2emSD2YIZgVNGyR0j0ARlEo0fKZZkrYDhVASy
   q45E6gqM8CK6pPu9oTVQYebmKCmcgGz8TGmlC3FpzaucsM3K9fhnPkt9a
   xePPkESCYH2ZeSK/cckA6/XqFiL1RoTzL6OP7jMBYi0FQRvngXw/K9WXX
   rhzGW5A3oClxDSS0WjRae1+AmRrI70R41AVsOYb1rwFNceaGkJtrs//WE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="336353721"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="336353721"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:23:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="600766882"
Received: from jvowlesx-mobl.amr.corp.intel.com (HELO [10.251.4.211]) ([10.251.4.211])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:23:52 -0700
Message-ID: <e9abfba4-d178-7ee5-da13-4cd9e07ba331@intel.com>
Date:   Mon, 23 May 2022 10:23:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Dave Hansen <dave.hansen@intel.com>
Subject: [GIT PULL] x86/sgx for v5.19
Content-Language: en-US
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

It's my first pull request, signing tags and all that jazz.  I hope I didn't
botch anything too badly.  Here we go:

Please pull a set of x86/sgx patches to fix crashes under SGX memory pressure.

---

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.19_rc1

for you to fetch changes up to e3a3bbe3e99de73043a1d32d36cf4d211dc58c7e:

  x86/sgx: Ensure no data in PCMD page after truncate (2022-05-16 15:17:57 -0700)

----------------------------------------------------------------
A set of patches to prevent crashes in SGX enclaves under heavy memory
pressure:

SGX uses normal RAM allocated from special shmem files as backing storage
when it runs out of SGX memory (EPC).  The code was overly aggressive when
freeing shmem pages and was inadvertently freeing perfectly good data.
This resulted in failures in the SGX instructions used to swap data back
into SGX memory.

This turned out to be really hard to trigger in mainline.  It was
originally encountered testing the out-of-tree "SGX2" patches, but later
reproduced on mainline.

Fix the data loss by being more careful about truncating pages out of
the backing storage and more judiciously setting pages dirty.

----------------------------------------------------------------
Reinette Chatre (5):
      x86/sgx: Disconnect backing page references from dirty status
      x86/sgx: Mark PCMD page as dirty when modifying contents
      x86/sgx: Obtain backing storage page with enclave mutex held
      x86/sgx: Fix race between reclaimer and page fault handler
      x86/sgx: Ensure no data in PCMD page after truncate

 arch/x86/kernel/cpu/sgx/encl.c | 113 +++++++++++++++++++++++++++++++++++++----
 arch/x86/kernel/cpu/sgx/encl.h |   2 +-
 arch/x86/kernel/cpu/sgx/main.c |  13 +++--
 3 files changed, 114 insertions(+), 14 deletions(-)

