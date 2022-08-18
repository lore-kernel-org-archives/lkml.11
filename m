Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D05C25B08
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 00:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbiHRAwN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 20:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiHRAwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:52:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B477972EC3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 17:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660783929; x=1692319929;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=58ON10/L8BlQ/a/6dmh5aWnxs++pUDrqF1IpJhK5uis=;
  b=F6EhzANPbbXku2kV/+bTJEN5agiuruB7WWKa08RJdLXjm0iNk1O38Vso
   iPr+bybRKhf1rZl7keZbhZEv/lhm2PZWIHxGFkwNZ8Qe/Wf4nY4LWY2ij
   HLg+yyfrR8uSTr29mZHSalL0jBve9hc7gZX6f/N/Rd+LoS+L7HqnWPYEk
   1ePCmXQlsiy7tBEkU3bCtAOzTA2HeC5DZSMq6/q3FrmQ02EmxPBYVIWW7
   RZnu29e3vAW+es6uWfox+S6qVLnxJEMsturNAScx5sy5D6VRlsQRJxvr8
   stj07L7ZnbOLQ/4bnByIK6122lELtlj+kT/S9/bs/Lu14v0pVoFaU2JH7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="272402439"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="272402439"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 17:52:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="935589924"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 17:52:07 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH -V3 0/8] migrate_pages(): fix several bugs in error path
References: <20220817081408.513338-1-ying.huang@intel.com>
        <20220817084833.b348d11eab362b2ac5a02259@linux-foundation.org>
Date:   Thu, 18 Aug 2022 08:51:56 +0800
In-Reply-To: <20220817084833.b348d11eab362b2ac5a02259@linux-foundation.org>
        (Andrew Morton's message of "Wed, 17 Aug 2022 08:48:33 -0700")
Message-ID: <87pmgybcgj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 17 Aug 2022 16:14:00 +0800 Huang Ying <ying.huang@intel.com> wrote:
>
>> error-inject.patch, test-migrate.c, and test-migrate.sh are as below.
>> It turns out that error injection is an important tool to fix bugs in
>> error path.
>
> Indeed, and thanks for doing this.
>
> Did you consider lib/*inject*.c?  If so, was it unsuitable?

I haven't take a deep look at that.  Will do that.

Best Regards,
Huang, Ying
