Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54913C4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 10:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiBVKKa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiBVKKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:10:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E21108BD4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:09:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D33C61566
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C53FC340E8;
        Tue, 22 Feb 2022 10:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645524565;
        bh=AkOMylrV6IyH78gdwpdLXnR+lLhy+UuR1r9cOg7vTv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeJuOA9MMWhRwGKKnmM7zP24hfmdei6GulopQDZMPIO0oCztaFA/HTdCuTJ9/RZVR
         SN8i5ipn0A8n0wvIwkYLoXiblypyeMN3oyjcZ/TwtX0Lek52NdYZBhkH40ZQWJJHGC
         h08R2W+jni0/wzJo0qRYehz22AUgZDq/iM1nLI2QHUfEdm0K4v2f/lZliDXU6jPnky
         ky9nYSjw/oEmEHGcB+ZnX0Yv9l+hXU6nXC4691AizpENbLs/A9pdIM77V7DVI7Jp4C
         0qNqHwHp+SV0BuDj5c7d714qBDQefiRsAYj9uq/2r46NXr27oNvvnYGBJSXzeXMvam
         6Ox43yLguc6sA==
Date:   Tue, 22 Feb 2022 10:09:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, acme@redhat.com, ardb@kernel.org,
        bp@alien8.de, broonie@kernel.org, dave.hansen@linux.intel.com,
        joey.gouly@arm.com, jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH v4 0/4] linkage: better symbol aliasing
Message-ID: <20220222100918.GA16108@willie-the-truck>
References: <20220216162229.1076788-1-mark.rutland@arm.com>
 <Yg4qV6GHaHuLrUmm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg4qV6GHaHuLrUmm@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Feb 17, 2022 at 11:58:31AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 16, 2022 at 04:22:25PM +0000, Mark Rutland wrote:
> > Catalin, Will, Peter: I think this is ready now and would like to get it
> > queued, but it looks like this may (trivially) conflict with other bits
> > we'll want to queue in either the arm64 tree (Joey's string routine
> > changes [4]), or tip tree (Peter's IBT series).
> > 
> > I assume the best thing to do would be to have a stable branch merged in
> > both of those. I've tagged this such that it can be pulled (details
> > below); Peter also suggested he could make a stable branch in the tip
> > tree. Any preference?
> 
> No real preference, The conflicts on my end are really rather trivial
> IIRC, but they're a nice clean-up.
> 
> If I don't take then, feel free to add:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Mark mentioned yesterday that this series will conflict with some pending
rework to the arm64 string routines [1], so we probably want a shared
branch to handle the fallout.

Do you plan to queue this someplace in -tip that I can pull from, or
shall I create a stable branch on the arm64 side?

Cheers,

Will

[1] https://lore.kernel.org/r/20220215170723.21266-1-joey.gouly@arm.com
