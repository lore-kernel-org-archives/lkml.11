Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 09:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbiF1JMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343557AbiF1JMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:12:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8B311A16
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:12:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B293B616D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04FBC3411D;
        Tue, 28 Jun 2022 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656407526;
        bh=gbZhQSU4/NR13gtRuxjYhIOnCtlwDWWV04C1FZnOxow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENx+jqPg8Q1l25f5JlLn1WnvjgZve+34Gk72KKOq3skyrDWZh5BxrS/SnHMp76ANT
         RefjS5BOV39tLha57CC+2P2lyAu/HfEK+Jgk+/OI3vTOldnq1gArTxpvU44WNtlqRQ
         ZuO2h7Cm6kwg/0VRG7bxH/tjicVqwRg6LhZXnoi8=
Date:   Tue, 28 Jun 2022 11:12:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Dani Liberman <dliberman@habana.ai>
Subject: Re: [PATCH 11/12] habanalabs/gaudi2: add tpm attestation info uapi
Message-ID: <YrrF4/kSbs+25BUR@kroah.com>
References: <20220627202620.961350-1-ogabbay@kernel.org>
 <20220627202620.961350-12-ogabbay@kernel.org>
 <YrqhaBuzY/GkQXHx@kroah.com>
 <CAFCwf13eVS4iETpdgRp72KoNw-X5h1Japf=pNQ-8MdQcJ4h8WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf13eVS4iETpdgRp72KoNw-X5h1Japf=pNQ-8MdQcJ4h8WQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:51:48AM +0300, Oded Gabbay wrote:
> On Tue, Jun 28, 2022 at 9:36 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jun 27, 2022 at 11:26:19PM +0300, Oded Gabbay wrote:
> > > From: Dani Liberman <dliberman@habana.ai>
> > >
> > > User will provide a nonce via the ioctl, and will retrieve
> > > attestation data of the boot from the tpm, generated using given
> > > nonce.
> >
> > Why not use the normal TPM api instead of a new/custom one?  Or is this
> > not a "normal" TPM device?  If not, you should say what it really is.
> >
> > thanks,
> >
> > greg k-h
> 
> Honestly, I'm not that knowledgeable about it. It is hidden behind our
> firmware code. We just provide a communication method between the
> userspace and the firmware, as the userspace can't interact directly
> with the f/w. i.e. The driver is a transparent tunnel, it doesn't
> interact with registers of the TPM device itself. The "real" driver is
> in our firmware.
> 
> So basically we just got definitions from the f/w how to fetch the
> data from them and how to expose it to the user and that's it.
> 
> What to do in this case ? Is this considered a "real" TPM ? I imagine
> I won't be able to connect to a standard tpm driver in the kernel as
> the h/w is not exposed to me.

How is this hardware designed?  Is the TPM in here supposed to be a
real TPM for userspace to use?  Or is this just a random hardware thing
that you use to validate your device somehow and is not supposed to be a
normal TPM as per the specification?

thanks,

greg k-h
