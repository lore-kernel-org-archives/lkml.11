Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B60EECAAD5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Aug 2022 22:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345145AbiHZW1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 18:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiHZW1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:27:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3678B786CD;
        Fri, 26 Aug 2022 15:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5924461525;
        Fri, 26 Aug 2022 22:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8591EC433D6;
        Fri, 26 Aug 2022 22:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661552832;
        bh=gaaSNaA2eKKcupVAdLGKzxk7JwBpgd5kCR196zUQpYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gOhgP3QRFotJ+3RnnjyBIc//CRZHne/aosFfh2Sa4UTVdrUjEuY/YRH29HukGzSWg
         /5qpGrqsoFX/Z854aVU84npe+WVn0abeUJRt/oKpjJoIJPNffoQ3PXBj8WgwfWsOsH
         9lQzly7ay+TwCE8Yt7n+0zk6lxT6gOIGOrjE/XordVvospdAGWJzx0Quok6DPc11wH
         MC1rNRlH3tDyztQGhzdZVNYa9LoZfxXRjocFUX4iUPcmJWWkrn2PYB9Lvf8qYS5OOS
         YBHQmKqIiMixwn52VYJx/mzW9Y3MDc7lPyebRI5PktxPcL9hE8g6ZsMqbwpfCA7+XD
         lnYxDtpeU1GsA==
Date:   Fri, 26 Aug 2022 15:27:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     menglong8.dong@gmail.com, sfr@canb.auug.org.au,
        bagasdotme@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v2] docs/conf.py: add function attribute
 '__fix_address' to conf.py
Message-ID: <20220826152711.6756e510@kernel.org>
In-Reply-To: <87zgfqsld6.fsf@meer.lwn.net>
References: <20220826160150.834639-1-imagedong@tencent.com>
        <20220826135839.39c7711f@kernel.org>
        <874jxyu32m.fsf@meer.lwn.net>
        <87zgfqsld6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 16:14:45 -0600 Jonathan Corbet wrote:
> Jonathan Corbet <corbet@lwn.net> writes:
> >> You'll need to CC netdev@ for the patch to get into the net-next tree.
> >> Since this is a pure Documentation/ patch get_maintainer.pl did not
> >> produce netdev@ in the recommended addresses.
> >>
> >> Please wait for a review/ack from Jon before reposting, we need his
> >> permission to apply this patch.  
> >
> > I could also just carry it through docs; I'm about to send a set of
> > fixes Linusward in any case.  I wanted to run a couple of tests to be
> > sure, but I don't expect any problems with it...  
> 
> The patch is clearly correct, it can go in via whatever path seems most
> suitable.  Let me know if you'd like me to push it; otherwise:
> 
> Acked-by: Jonathan Corbet <corbet@lwn.net>

Oh, if it can make it to Linus via the doc tree before the 6.1 merge
window that's even better!
