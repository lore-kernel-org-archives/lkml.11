Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EACC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 18:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbiEXSl0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 14:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiEXSlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:41:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3109630D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653417680; x=1684953680;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=j/5DR7tzKkv9kqbWuOe2Gdq9+5NSpJjwV1s4Q6desGs=;
  b=gURDOz6LvuWqBGJFinolwUJfYIAEgrrZkpU9DX4uOc/oXKTERGqTrRO0
   Lm/0eB5wIkZM0NOvwNrvMRDk3iFLCbI9xPXE6SGR2Ld8olsNJAByf6T/Q
   QBU6FaOExqnmJLO8bveay9A8w+fQCJPCAA0moaSblMqkFk1S6fhSiIiSI
   GzXuCCmf5ICYvZGhjhgwQzsGvRhnl2+VDJFpodbEywFxeRlFEVIgGyDJd
   32ZZO2XGYg+zyAxt95tiZkRxUawBG5+iojOpSrireFGbQYVK0l0mNuXNb
   PgKgsxgY1dBuilVmPrXqxY/d64loqEeMXUIvKwrBFVtqJdry+gXQkM4T/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273350586"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273350586"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 11:41:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="745348189"
Received: from tatac-mobl.amr.corp.intel.com (HELO [10.212.199.159]) ([10.212.199.159])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 11:41:20 -0700
Message-ID: <bc5e9175-e609-d5f8-da33-65e97d4fd813@intel.com>
Date:   Tue, 24 May 2022 11:41:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] x86/resctrl: Fix to restore to original value when
 re-enabling hardware prefetch register
Content-Language: en-US
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>, fenghua.yu@intel.com,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20220518045517.2066518-1-tarumizu.kohei@fujitsu.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220518045517.2066518-1-tarumizu.kohei@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 21:55, Kohei Tarumizu wrote:
> The current pseudo_lock.c code overwrites the value of the
> MSR_MISC_FEATURE_CONTROL to 0 even if the original value is not 0.
> Therefore, modify it to save and restore the original values.
> 
> Fixes: 018961ae5579 ("x86/intel_rdt: Pseudo-lock region creation/removal core")
> Fixes: 443810fe6160 ("x86/intel_rdt: Create debugfs files for pseudo-locking testing")
> Fixes: 8a2fc0e1bc0c ("x86/intel_rdt: More precise L2 hit/miss measurements")
> Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>

Those commits are pretty old.  Is there any reason this is not stable@
material?
