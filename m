Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79855C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 21:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiD0VJy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbiD0VJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365E78A308;
        Wed, 27 Apr 2022 14:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B326961053;
        Wed, 27 Apr 2022 21:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1635FC385A7;
        Wed, 27 Apr 2022 21:05:36 +0000 (UTC)
Date:   Wed, 27 Apr 2022 17:05:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] timekeeping: Introduce fast accessor to clock
 tai
Message-ID: <20220427170535.37dbcad7@gandalf.local.home>
In-Reply-To: <87fslyw94e.fsf@kurt>
References: <20220414091805.89667-1-kurt@linutronix.de>
        <20220414091805.89667-2-kurt@linutronix.de>
        <20220426175338.3807ca4f@gandalf.local.home>
        <87r15i9azg.fsf@kurt>
        <20220427112759.1cedda69@gandalf.local.home>
        <87fslyw94e.fsf@kurt>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 22:42:57 +0200
Kurt Kanzenbach <kurt@linutronix.de> wrote:

> Thanks for debugging it!

Unfortunately, I found that 32 bit is still broken. Will have that fixed
soon.

-- Steve
