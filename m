Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0B8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 16:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbiBIQ1v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 11:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiBIQ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:27:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E8AC050CE5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:27:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D675B6182A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 16:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F0EC340E7;
        Wed,  9 Feb 2022 16:27:04 +0000 (UTC)
Date:   Wed, 9 Feb 2022 11:27:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, paulmck@kernel.org
Subject: Re: [PATCH 05/12] drm/i915: Protect lockdep functions with #ifdef
Message-ID: <20220209112703.1679e48b@gandalf.local.home>
In-Reply-To: <87iltonoaa.fsf@intel.com>
References: <20220208184208.79303-1-namhyung@kernel.org>
        <20220208184208.79303-6-namhyung@kernel.org>
        <87y22lp4xx.fsf@intel.com>
        <CAM9d7ci0By5zioo+52+14RuFrTqZfzbupJuP-908HhYB2Ovc9A@mail.gmail.com>
        <87iltonoaa.fsf@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Feb 2022 15:49:01 +0200
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> > Because I want to use the lockdep annotation for other purposes.
> > But the workqueue lockdep_map was defined under LOCKDEP
> > only.  Please see the description in the cover letter.
> >
> > https://lore.kernel.org/all/20220208184208.79303-1-namhyung@kernel.org/  
> 
> So lockdep_init_map() might still be there and build just fine for
> CONFIG_LOCKDEP=n, but now we're actually required to wrap all call sites
> in #ifdefs depending on the purpose? I'm not convinced yet.

I addressed this already. I suggested to add a "raw" variant that turns to
a nop when LOCKDEP is not enabled. That is, for those locations that are
only for working with LOCKDEP, the call will be:

	lockdep_init_map_raw()

This will differentiate the locations that are for just lockdep and those
that are for both lockdep and tracing.

-- Steve
