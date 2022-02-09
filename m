Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED386C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 13:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiBINtI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 08:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiBINtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:49:06 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DA2C0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644414548; x=1675950548;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xB0C6L4R4DIOk4u7CJIneOR/rhpe5z/8zU+Ja7drdaU=;
  b=jsZP2nuOs07WVUum8ILu4kp3CqgoC2fpWBC0UqGqv/3ZQ2hHp4LCcLCB
   Ekw+WgK2+5KDua2I287HMHoLBIOkESZIOlNicd/Jz3pfAKvVyQppTHqyb
   xTvfiOYyxqf2GvNzFnebiTKAfi1unTKyn0tZo88LI1Caz4btoXGnqVxpy
   lclI4ao09y0ZP5XKx5v2g/lAWomw5iKRn4s9E9ywA5a65AqGxxxZhsTdd
   Psw4ScCeaqqAPrhbfBb53s3oljVQ2ToKIYdEqnHhl/AiDNfWMR9lRvoOd
   vZJw7qH3bJQaMbMN3UsBWetqZVPmi3lY+NDvueSsi7Q4E5XOF3liatILe
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="312500047"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="312500047"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:49:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="629277063"
Received: from rcallina-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.18.41])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:49:04 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, paulmck@kernel.org
Subject: Re: [PATCH 05/12] drm/i915: Protect lockdep functions with #ifdef
In-Reply-To: <CAM9d7ci0By5zioo+52+14RuFrTqZfzbupJuP-908HhYB2Ovc9A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220208184208.79303-1-namhyung@kernel.org>
 <20220208184208.79303-6-namhyung@kernel.org> <87y22lp4xx.fsf@intel.com>
 <CAM9d7ci0By5zioo+52+14RuFrTqZfzbupJuP-908HhYB2Ovc9A@mail.gmail.com>
Date:   Wed, 09 Feb 2022 15:49:01 +0200
Message-ID: <87iltonoaa.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Feb 2022, Namhyung Kim <namhyung@kernel.org> wrote:
> Hello,
>
> On Tue, Feb 8, 2022 at 10:51 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>
>> On Tue, 08 Feb 2022, Namhyung Kim <namhyung@kernel.org> wrote:
>> > With upcoming lock tracepoints config, it'd define some of lockdep
>> > functions without enabling CONFIG_LOCKDEP actually.  The existing code
>> > assumes those functions will be removed by the preprocessor but it's
>> > not the case anymore.  Let's protect the code with #ifdef's explicitly.
>>
>> I don't understand why you can't keep the no-op stubs for
>> CONFIG_LOCKDEP=n.
>
> Because I want to use the lockdep annotation for other purposes.
> But the workqueue lockdep_map was defined under LOCKDEP
> only.  Please see the description in the cover letter.
>
> https://lore.kernel.org/all/20220208184208.79303-1-namhyung@kernel.org/

So lockdep_init_map() might still be there and build just fine for
CONFIG_LOCKDEP=n, but now we're actually required to wrap all call sites
in #ifdefs depending on the purpose? I'm not convinced yet.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
