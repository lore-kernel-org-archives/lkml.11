Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BC3C25B0D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 21:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiHIVUR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 17:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiHIVTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:19:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BC467162
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 14:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3555A60C21
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21422C433D7;
        Tue,  9 Aug 2022 21:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660079981;
        bh=wpAYvNLKW+cILOGhRlOddPjGyN9kg8VjHUMnWtFlMK4=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=Zn7aJyGUTW54gFwJboItIH37mFBim6Z58bi4P5u1BXs0WBZsXdEvrPV9G4vCEGBco
         WQPfP/kQBiA3Dwe27rPz3IRI8QIxNkhhAeKcKHZhzOK22NhG9xjGN/rCpof17/+UIF
         BXuVCbnZiBYgopWaqNEmjbrTj6mYx1FUXPEDk8tu8M61RvIPBlfYO6F20/+ct8Zmsm
         0KarB0Th+8hgE27ykEyeXRL9hwJUWeOuIwYu1mRp9iMjDBu3iW7ja8eQlL+bpuceE4
         W88t75n7/r6AADpq+n2zIBtysZC9m9Jg33guDgG7DmLSf+mTX5zSYhHVxONbvAS7mD
         doBFCxNFNxRbw==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id DAA9727C0054;
        Tue,  9 Aug 2022 17:19:39 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Tue, 09 Aug 2022 17:19:39 -0400
X-ME-Sender: <xms:a8_yYqStzjnXYo2K-NZXVtmXjIu3klfLXMy5ofle9sNR2-uHUVab8g>
    <xme:a8_yYvxiJ-DXgdK_FYbJLY2yLrsOEZAgJmT7dsLDZ3xLGNXMQC0sYO0_kfLrkfdkm
    GjauTw73iEAMKk1P0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehnugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepudevffdvgedvfefhgeejjeelgfdtffeukedugfekuddvtedv
    udeileeugfejgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudei
    udekheeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlih
    hnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:a8_yYn3lY5Ouyx_GSE7O5H9a37IDOdTQHK2B-8FDa1CA7gBS49YeXA>
    <xmx:a8_yYmBw1rtrjoF1orbHJDNFm7Qo8dQ_fHDk9YSYspFpFXbseIYwjg>
    <xmx:a8_yYjjdB7gE2ta4mkrxSSOYfGcmlhgFiNDlMKY9OCDdkhRWJUZg0Q>
    <xmx:a8_yYpbz8L03GADtnSZUdSQHPMhdsCu9BDKDvsr5eFAd-3LzIacIWQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 471B431A0062; Tue,  9 Aug 2022 17:19:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-811-gb808317eab-fm-20220801.001-gb808317e
Mime-Version: 1.0
Message-Id: <c2f42cfd-82d4-4ab7-92b9-a173d6cdd29d@www.fastmail.com>
In-Reply-To: <01768c70-a012-0d08-cfa5-a7a87ff0a19c@intel.com>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-6-ira.weiny@intel.com>
 <5d62c1d0-7425-d5bb-ecb5-1dc3b4d7d245@intel.com> <Yu4t0jkpIY4grgxL@gmail.com>
 <Yu4wON0MRGH7h5Jv@zn.tnic> <Yu+Nwbn4CZUmyD14@gmail.com>
 <Yu+VV8xFTYRh0D0a@zn.tnic> <YvAaXet3sBg3mRDe@iweiny-desk3>
 <YvDtfKRyMGenRMU5@gmail.com> <01768c70-a012-0d08-cfa5-a7a87ff0a19c@intel.com>
Date:   Tue, 09 Aug 2022 14:19:19 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Dave Hansen" <dave.hansen@intel.com>,
        "Ingo Molnar" <mingo@kernel.org>, "Ira Weiny" <ira.weiny@intel.com>
Cc:     "Borislav Petkov" <bp@alien8.de>,
        "Rik van Riel" <riel@surriel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Aug 8, 2022, at 9:16 AM, Dave Hansen wrote:
> On 8/8/22 04:03, Ingo Molnar wrote:
>>> Again, I don't believe this is too much overhead but I don't want pe=
ople=20
>>> to say it was not discussed.
>> Is it necessary to do this, what are the alternatives, can this overh=
ead be=20
>> avoided?
>
> One thing Andy mentioned is that we _could_ get it down to two instruc=
tions:
>
> 	rdgsbase $reg
> 	push $reg
>
> This could be hidden in:
>
> 	PUSH_PTREGS_AUXILIARY
>
> where, today, it would only net add a single instruction.  But, if we
> ever add more stuff to PUSH_PTREGS_AUXILIARY, it would move back to
> needing two instructions since we'd need both the:
>
> 	subq $PTREGS_AUX_SIZE, %rsp
>
> and something to write gsbase to the stack.
>
> That doesn't get us the smp_processor_id() directly, but we can derive
> it later on from the gsbase value.
>
> The downside is that we're doing it in assembly.  We'd also have
> something additional which is a bit uglier and that reads memory on
> !X86_FEATURE_FSGSBASE, probably:
>=09
> 	movq    PER_CPU_VAR(cpu_number), %reg
> 	push %reg

Nah, I believe the same value that RDGSBASE reads is already in percpu m=
emory as 'per_cpu_offset', so the alternative can just read that and the=
 code that uses it doesn=E2=80=99t need to care about the alternative.

>
> Which would require some different code to decode what was there:
>
> int read_exception_cpu_number(ext_pt_regs *e)
> {
> 	if (cpu_feature_enabled(X86_FEATURE_FSGSBASE))
> 		return gsbase_to_cpu_number(e->ext_cpu_nr);
> 	else
> 		return e->ext_cpu_nr;
> }
>
> I'm thinking that the whole racy smp_processor_id() thing wasn't so bad
> in the first place.
