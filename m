Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D72EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 19:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiBIT5T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 14:57:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiBIT5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:57:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982BDE034DE6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:57:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 637F3CE2292
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7ECC340E7;
        Wed,  9 Feb 2022 19:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644436632;
        bh=5djWLdsRTAB20pqF+K1YZTXuQoxV9r+sHGJINjpDmfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VKWwWpVkSOW56M+ClqQ/I66Dbg/FgiZ1dZfW8bRJC0OBvddHRL8jFfzoSm8u7AqXS
         3OrxkqCVBBgTQmWaGxtwFQJBTKRdWnCWF458fw6x/NzjWwO1jcxFhqGvWWHbImuMbX
         rnY8Mx7QJQECHjrh9klbwRapc5gXAY9BSfQpu8Fk2O5SXk0KzAdX/L+/7f39Rh6AE5
         Q2m1ilhdIAQa5Zxvf+X9UhRmFICHHDv6b/lfYVxz4LAszyiXHNiySBmLYYg0GsuHSf
         Vd75hZCVrofgsKmq+rFWlS7gXxbpUogJOcSrRTAmtG508/Bt2vEOaADVFYMktTgT4X
         r8r7EI4Fmj7KA==
Date:   Wed, 9 Feb 2022 20:57:09 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v3 7/7] arm64: support PREEMPT_DYNAMIC
Message-ID: <20220209195709.GA557593@lothringen>
References: <20220209153535.818830-1-mark.rutland@arm.com>
 <20220209153535.818830-8-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209153535.818830-8-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 03:35:35PM +0000, Mark Rutland wrote:
> Note that PREEMPT_DYNAMIC is `def bool y`, so this will default to
> enabled.

It should probably be "def_bool y if HAVE_STATIC_CALL_INLINE"...

Thanks.
