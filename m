Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED05C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 05:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242985AbiC3F3W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbiC3F3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:29:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF161B2C67;
        Tue, 29 Mar 2022 22:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648618053; x=1680154053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sjK0Kgwyd9ij8Ko4lu7GzQVOqQuqzUpIKUJP3zs+o/k=;
  b=B494mchkyIfytYXCc7VAq01Itb5ZqTXiu1Be8BhYGcfPercvP6POEHMI
   708Od6GOMeasEZLIR7NgBMwGLqokLjhh/mBAD3rzz3vHKvVRZ/fJ+mAUN
   YpjL9Dbo+GkVC7Objjt5+zTcd+G1EsQGDZ8qvNT8jo/DnWbsHE5lJXIvY
   CHoa/XYqNRpadyhgiw7VgNi+9r2jnJC8gg/czeJJ3YGBPuuOAX49twfQm
   l8FZaONuGb5UkPTE6bQeJkJ4smsQn1XdqWyk+B8Gpy7FHl+x2RTBnqHb7
   v9zg+c/KShqXSt/0abd6S1nsTh83A2MpeYz+yfCKE1VMhc2UtiS/UGTs6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="239379515"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="239379515"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 22:27:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="618398597"
Received: from jahay1-mobl1.amr.corp.intel.com (HELO guptapa-desk) ([10.209.124.134])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 22:27:32 -0700
Date:   Tue, 29 Mar 2022 22:27:30 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        antonio.gomez.iglesias@linux.intel.com, neelima.krishnan@intel.com,
        stable@vger.kernel.org, Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 2/2] x86/tsx: Disable TSX development mode at boot
Message-ID: <20220330052730.odzigmf4dkqkqfhk@guptapa-desk>
References: <cover.1646943780.git.pawan.kumar.gupta@linux.intel.com>
 <347bd844da3a333a9793c6687d4e4eb3b2419a3e.1646943780.git.pawan.kumar.gupta@linux.intel.com>
 <YkMyo2Jw8iYx9wAU@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <YkMyo2Jw8iYx9wAU@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 06:24:03PM +0200, Borislav Petkov wrote:
>On Thu, Mar 10, 2022 at 02:02:09PM -0800, Pawan Gupta wrote:
>> A microcode update on some Intel processors causes all TSX transactions
>> to always abort by default [*]. Microcode also added functionality to
>> re-enable TSX for development purpose. With this microcode loaded, if
>> tsx=on was passed on the cmdline, and TSX development mode was already
>> enabled before the kernel boot, it may make the system vulnerable to TSX
>> Asynchronous Abort (TAA).
>>
>> To be on safer side, unconditionally disable TSX development mode at
>> boot. If needed, a user can enable it using msr-tools.
>>
>> [*] Intel Transactional Synchronization Extension (Intel TSX) Disable Update for Selected Processors
>>     https://cdrdv2.intel.com/v1/dl/getContent/643557
>>
>> Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
>> Suggested-by: Borislav Petkov <bp@alien8.de>
>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>  arch/x86/include/asm/msr-index.h       |  4 +--
>>  arch/x86/kernel/cpu/cpu.h              |  1 +
>>  arch/x86/kernel/cpu/intel.c            |  4 +++
>>  arch/x86/kernel/cpu/tsx.c              | 34 ++++++++++++++++++++++++++
>>  tools/arch/x86/include/asm/msr-index.h |  4 +--
>>  5 files changed, 43 insertions(+), 4 deletions(-)
>
>Does this a lot more encapsulated version work too?

Neelima is testing this patch, she will share the results tomorrow.

Thanks,
Pawan
