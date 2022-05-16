Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121C9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 09:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbiEPJuN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 05:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiEPJuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:50:07 -0400
X-Greylist: delayed 346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 May 2022 02:50:05 PDT
Received: from vik-lap.sysgo.cz (dynamic-2a01-0c22-9170-4b00-8d03-2ed4-b08c-7f42.c22.pool.telefonica.de [IPv6:2a01:c22:9170:4b00:8d03:2ed4:b08c:7f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD8137034;
        Mon, 16 May 2022 02:50:05 -0700 (PDT)
Received: from vik-lap.sysgo.cz (localhost [127.0.0.1])
        by vik-lap.sysgo.cz (8.15.2/8.15.2/Debian-22) with ESMTP id 24G9hnss011800;
        Mon, 16 May 2022 11:43:49 +0200
Received: (from vik@localhost)
        by vik-lap.sysgo.cz (8.15.2/8.15.2/Submit) id 24G9hmTC011799;
        Mon, 16 May 2022 11:43:48 +0200
X-Authentication-Warning: vik-lap.sysgo.cz: vik set sender to vit@kabele.me using -f
Date:   Mon, 16 May 2022 11:43:48 +0200
From:   Vit Kabele <vit@kabele.me>
To:     Borislav Petkov <bp@alien8.de>
Cc:     platform-driver-x86@vger.kernel.org, r.marek@assembler.cz,
        x86@kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH v2] arch/x86: Check validity of EBDA pointer in mpparse.c
Message-ID: <YoIc1AHLK4pfR4AI@czspare1-lap.sysgo.cz>
References: <CAJZ5v0gBbdzUO9MRxbKESEnaeaNAu-+3oP6ADMretch=iHPNJA@mail.gmail.com>
 <Yk/2dh4kDobivStp@czspare1-lap.sysgo.cz>
 <YnFoIzmt1qJSucAd@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnFoIzmt1qJSucAd@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 07:36:35PM +0200, Borislav Petkov wrote:
> > diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
> > index fed721f90116..9e0b4820f33b 100644
> > --- a/arch/x86/kernel/mpparse.c
> > +++ b/arch/x86/kernel/mpparse.c
> > @@ -633,8 +633,18 @@ void __init default_find_smp_config(void)
> >  	 */
> >  
> >  	address = get_bios_ebda();
> > -	if (address)
> > -		smp_scan_config(address, 0x400);
> > +
> > +	/*
> > +	 * Check that the EBDA address is sane and the get_bios_ebda() did not
> > +	 * return just garbage from memory.
> > +	 * The upper bound is considered valid if it points below 1K before
> > +	 * end of the lower memory (i.e. 639K). The EBDA can be smaller
> > +	 * than 1K in which case the pointer will point above 639K but that
> > +	 * case is handled in step 2) above, and we don't need to adjust scan
> > +	 * size to not bump into the memory above 640K.
> > +	 */
> > +	if (address >= BIOS_START_MIN && address < (BIOS_START_MAX - 1024))
> > +		smp_scan_config(address, 1024);
> >  }
> 
> I guess but looking at reserve_bios_regions(), that function is already
> doing kinda the same along with being a bit more careful to figure out
> bios_start so you could unify the code into a common helper and use it
> at both places?
I also initially thought of extracting the check to a separate method,
but imo this decreases the overall code readability. Any function
calling the get_bios_ebda() must check the returned value anyway, so
there will be always at least one if statement involved. And the valid
upper bound of the EBDA pointer is also different for these two use-cases.
(The mpparse.c usage is interested in EBDA pointer only if it ends 1KiB
before the end of low memory, while the ebda.c accepts even the values in the
last KiB below 640KiB).

I also consider it unlikely that there will be some new code using
the same bounds check, so I'd prefer to leave it inline.

-- 
Best regards,
Vit Kabele
