Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A11C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 16:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiGTQLX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGTQLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:11:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2598F52E5A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4A54B820CB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28DFC3411E;
        Wed, 20 Jul 2022 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658333476;
        bh=Xt/DfdvnU1bf+PXH991LiVKp35fEpOjeqb3QVMrfg7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YH2eulptE0PWIqaZvG9VJnbjP1DFMUlliKk05/RECmUiVlq5/JNFc8iI4p+et3nuB
         aJ2e0hQSsHhv2M04GoPxheSqhz17/qPmSepUYE3UKnfclFwCIKiWibhz4rpKi1s9/P
         Ec2iMS8TRDyJs7BVHfsB1GKKClwVGQ6bkak1RXn+GE0YFGl7t3wkYX3Kg2r0GrGkKT
         VqwPh0a2BfnkKwGjW7hW6LBrqC6p5np69HbsMZfW6T9bDzQIbkbAJRBZWdUBrkkf61
         T3aA5my7IMcse3AQLU62FkAv9StuIR84J9keaVemucFrOfW/HoE+DuPxTrmattoDBY
         eETWxviLlVZSw==
Date:   Wed, 20 Jul 2022 17:11:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     =?utf-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?= 
        <haibinzhang@tencent.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Martin Ma <Martin.Ma@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hewenliang4@huawei.com" <hewenliang4@huawei.com>
Subject: Re: [PATCH V2] arm64: fix oops in concurrently setting
 insn_emulation sysctls
Message-ID: <20220720161110.GA16493@willie-the-truck>
References: <9A004C03-250B-46C5-BF39-782D7551B00E@tencent.com>
 <YtfzvK0T8pJacsDm@google.com>
 <20220720151344.GA16452@willie-the-truck>
 <YtggOdLN5NuFkFrl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtggOdLN5NuFkFrl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 04:33:13PM +0100, Lee Jones wrote:
> On Wed, 20 Jul 2022, Will Deacon wrote:
> > On the plus side, the patch has a Link: tag to this thread, so the
> > Fixes tag is retrievable if you're determined enough.
> > 
> > If somebody wants this for stable, then I suppose they'll have to send
> > a backport to make sure it doesn't get missed.
> 
> I'll add it to my TODO.

Brill, thanks Lee.

Will
