Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FA5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 20:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiD0UOo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 16:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbiD0UOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:14:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C0890CEC;
        Wed, 27 Apr 2022 13:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20557B8291B;
        Wed, 27 Apr 2022 20:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D62C385A7;
        Wed, 27 Apr 2022 20:08:11 +0000 (UTC)
Date:   Wed, 27 Apr 2022 16:08:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] timekeeping: Introduce fast accessor to clock
 tai
Message-ID: <20220427160810.682c9c3d@gandalf.local.home>
In-Reply-To: <87pml2wasm.ffs@tglx>
References: <20220414091805.89667-1-kurt@linutronix.de>
        <20220414091805.89667-2-kurt@linutronix.de>
        <20220426175338.3807ca4f@gandalf.local.home>
        <87r15i9azg.fsf@kurt>
        <20220427112759.1cedda69@gandalf.local.home>
        <87pml2wasm.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 22:06:49 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Haven't found where ftrace loses the upper bit, but it does so
> somewhere.

https://lore.kernel.org/all/20220427153339.16c33f75@gandalf.local.home/

 ;-)

-- Steve
