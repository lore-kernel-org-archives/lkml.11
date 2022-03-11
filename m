Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EE3C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 11:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348092AbiCKLJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 06:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiCKLJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:09:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06645A09C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:08:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64895B82A4F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B0FC340E9;
        Fri, 11 Mar 2022 11:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646996898;
        bh=hspmc5M8s5pLeqE8HNdVN69JkwqX0FSogsQCynZXC8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PvbSa6a8YEE8lJo4PoZQqjpCzuGLfImZPblBtp9aVMrEUCidHBpE/2ruFK9BI67Qn
         za8U8u0FHbxeu7bHD0nHm0n25lE4YmzMYV6pTv+6HvJFs602R3s0JKb+qfL1ukDo03
         aIUtjx4yKIAjnhXNdNYP/dWaeTevfxlH6BgixdtFSHDmed62G1lZeUfUYLkXA/dzgY
         XvdcfRnvca+aSK9VfgjzkQzsQKPogcCSu6qOtmKOwQD/oZMi5fIBHv0jdqkiw0kS8A
         sItPNZTW6iDvuxjh2/luh/SUQrWb0wpgO1MaJ+68CjY3zNzuDb0IoTTBIDXVXMpG+Z
         +sxuWvg6t7yOw==
Date:   Fri, 11 Mar 2022 12:08:14 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Scenario TREE07 with CONFIG_PREEMPT_DYNAMIC=n?
Message-ID: <20220311110814.GA96127@lothringen>
References: <20220310215630.GA3490034@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310215630.GA3490034@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 01:56:30PM -0800, Paul E. McKenney wrote:
> Hello, Frederic,
> 
> I recently added CONFIG_PREEMPT_DYNAMIC=n to the TREE07 file, and since
> then am getting roughly one RCU CPU stall warning (or silent hang)
> per few tens of hours of rcutorture testing on dual-socket systems.
> The stall warnings feature starvation of RCU grace-period kthread.
> 
> Any advice on debugging this?
> 
> 							Thanx, Paul

Ok it reproduces easily but I have no clue about the origin. I'm starting a
bisection.

Thanks!
