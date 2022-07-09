Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D2ACCA47C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Jul 2022 09:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiGIJ4u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Jul 2022 05:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGIJ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548371F2F6;
        Sat,  9 Jul 2022 02:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E537B60B6F;
        Sat,  9 Jul 2022 09:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4EBC3411C;
        Sat,  9 Jul 2022 09:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657360607;
        bh=PbPaVryS3IfrLqQ1B9Ls9PPUnr4E5iWT9w5+tUrG/SU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=riY1cZ27C76IkL7GJt4UKOvxVIoiho/oMGtH2RQ17N/urCtX9PsAD3/2OxUen05PS
         uZJf4HUc0MLgcPvohCH5gu13TXIzsnCIbV/kOzVrqcx+/+Ay0mMqRDEPe+uKUT2SzM
         1Zp4xESSttL5VTpOg3FiBLSwWS6SjIm3xg1qWafdCVsQkPimtkqv8RCpEhk18WQ8Cb
         F/kwALhaLzftWcjWezq7nGbBfR28H7rEJarRZu3sDhiAwSywUL6MW0igrv6jhi/UOl
         Ya+9ljZ7gCKeO3OmvarM4WzmxJ+r9UTaNxllha5Qk5r5UpBa3NkMP+eDijKRkYXPN5
         DUW6U74f/xkpA==
Date:   Sat, 9 Jul 2022 10:56:40 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] docs: alsa: alsa-driver-api.rst: remove a
 kernel-doc file
Message-ID: <20220709105640.376ff45c@sal.lan>
In-Reply-To: <87y1x9xclg.wl-tiwai@suse.de>
References: <cover.1656759988.git.mchehab@kernel.org>
        <3cd6b93b36b32ad6ae160931aaa00b20688e241a.1656759989.git.mchehab@kernel.org>
        <87y1x9xclg.wl-tiwai@suse.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 04 Jul 2022 14:54:19 +0200
Takashi Iwai <tiwai@suse.de> escreveu:

> On Sat, 02 Jul 2022 13:07:42 +0200,
> Mauro Carvalho Chehab wrote:
> > 
> > This file:
> > 	sound/core/compress_offload.c
> > 
> > Doesn't define any docs, as everything is inside the header
> > file. So, drop it, in order to remove a Sphinx warning.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>  
> 
> Hmm, it looks rather like that some comments (at least for exported
> functions) should be marked with kerneldoc markers instead.
> 
> I'm going to fix those comments.

Go for it: adding kerneldoc markers is indeed a better solution :-)

Regards,
Mauro

> 
> 
> thanks,
> 
> Takashi
> 
> > ---
> > 
> > To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/
> > 
> >  Documentation/sound/kernel-api/alsa-driver-api.rst | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/Documentation/sound/kernel-api/alsa-driver-api.rst b/Documentation/sound/kernel-api/alsa-driver-api.rst
> > index d24c64df7069..3cf8eb4ecaf4 100644
> > --- a/Documentation/sound/kernel-api/alsa-driver-api.rst
> > +++ b/Documentation/sound/kernel-api/alsa-driver-api.rst
> > @@ -86,7 +86,6 @@ Compress Offload
> >  
> >  Compress Offload API
> >  --------------------
> > -.. kernel-doc:: sound/core/compress_offload.c
> >  .. kernel-doc:: include/uapi/sound/compress_offload.h
> >  .. kernel-doc:: include/uapi/sound/compress_params.h
> >  .. kernel-doc:: include/sound/compress_driver.h
> > -- 
> > 2.36.1
> >   
