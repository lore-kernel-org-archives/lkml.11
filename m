Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4EDC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 12:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbiBJMBP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 07:01:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbiBJMBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:01:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 091E12620
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:01:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2342113E;
        Thu, 10 Feb 2022 04:01:14 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E7433F73B;
        Thu, 10 Feb 2022 04:01:03 -0800 (PST)
Date:   Thu, 10 Feb 2022 12:00:56 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v3 7/7] arm64: support PREEMPT_DYNAMIC
Message-ID: <YgT+eHjtgrHl+wWw@FVFF77S0Q05N>
References: <20220209153535.818830-1-mark.rutland@arm.com>
 <20220209153535.818830-8-mark.rutland@arm.com>
 <20220209195709.GA557593@lothringen>
 <YgTdHfmubmk1rUi8@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgTdHfmubmk1rUi8@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 09:38:37AM +0000, Mark Rutland wrote:
> On Wed, Feb 09, 2022 at 08:57:09PM +0100, Frederic Weisbecker wrote:
> > On Wed, Feb 09, 2022 at 03:35:35PM +0000, Mark Rutland wrote:
> > > Note that PREEMPT_DYNAMIC is `def bool y`, so this will default to
> > > enabled.
> > 
> > It should probably be "def_bool y if HAVE_STATIC_CALL_INLINE"...
> 
> Sure; I'm more than happy to fold that into patch 5.

For the moment I've made that:

	def_bool y if HAVE_PREEMPT_DYNAMIC_CALL

... since that fit more neatly with the other bits I had to add, and didn't
change the existing behaviour of 32-bit x86.

Please shout if you think that should be HAVE_STATIC_CALL_INLINE specifically!

Thanks,
Mark.
