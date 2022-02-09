Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B73EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 21:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiBIVPk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 16:15:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiBIVPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:15:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44272C1DC161
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 13:15:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 045251F391;
        Wed,  9 Feb 2022 21:15:40 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48ABB13638;
        Wed,  9 Feb 2022 21:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q+/QAfkuBGJyIwAAMHmgww
        (envelope-from <dave@stgolabs.net>); Wed, 09 Feb 2022 21:15:37 +0000
Date:   Wed, 9 Feb 2022 13:08:24 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH REPOST] locking/local_lock: Make the empty local_lock_*()
 function a macro.
Message-ID: <20220209210824.wwsq63z4o6a6ei7a@offworld>
References: <YgKjciR60fZft2l4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YgKjciR60fZft2l4@linutronix.de>
User-Agent: NeoMutt/20211029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Feb 2022, Sebastian Andrzej Siewior wrote:

>It has been said that local_lock() does not add any overhead compared to
>preempt_disable() in a !LOCKDEP configuration. A micro benchmark showed
>an unexpected result which can be reduced to the fact that local_lock()
>was not entirely optimized away.
>In the !LOCKDEP configuration local_lock_acquire() is an empty static
>inline function. On x86 the this_cpu_ptr() argument of that function is
>fully evaluated leading to an additional mov+add instructions which are
>not needed and not used.
>
>Replace the static inline function with a macro. The typecheck() macro
>ensures that the argument is of proper type while the resulting
>disassembly shows no traces of this_cpu_ptr().
>
>Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>Reviewed-by: Waiman Long <longman@redhat.com>

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
