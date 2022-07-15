Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934FFCCA47C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 05:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiGOFU2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 01:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGOFUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 01:20:24 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BF3796A3;
        Thu, 14 Jul 2022 22:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zO43hikXt0XV2hT6fYiuYzmsqvmr44gi7YAHVOdw6qY=;
  b=Ujpob+adTWG6OU7Rjosi+l0EP6AZRUFKPAvJG9QJnPKKLflW7e5U8Lve
   xsfqeF/zLzruSSAYdlKuG84punOx5Jw8zDC9lPwdzpOWjwn5gNTc9l4fX
   JFKbwj9GVh3hxIQAaXjqFXx5TiXlcQS5BiOGoS/4AyV3LK9+VP/GaMnHO
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.92,272,1650924000"; 
   d="scan'208";a="19373232"
Received: from 150.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.150])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 07:20:21 +0200
Date:   Fri, 15 Jul 2022 07:20:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Steve French <smfrench@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Yu Zhe <yuzhe@nfschina.com>
Subject: Re: Is casting a void ptr to something else considered bad kernel
 coding style
In-Reply-To: <CAH2r5msuc3-1V+dh5NdwnE6uBoN+7_cf=m6kwrFrTnwArND0LQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2207150717570.3006@hadrien>
References: <CAH2r5msuc3-1V+dh5NdwnE6uBoN+7_cf=m6kwrFrTnwArND0LQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jul 2022, Steve French wrote:

> For examples like this where a pointer which is (void *) is cast to
> something else, is this considered bad coding style in kernel C
> programming?
>
> It may be that leaving the (unnecessary) cast in, although it is not
> required for C, makes the code clearer in some cases.
>
> Any opinions on changes to remove casts of void pointers for kernel
> code (which I have recently seen suggested)?
>
> for example:
>
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -354,7 +354,7 @@ fill_small_buf(__le16 smb2_command, struct cifs_tcon *tcon,
>                void *buf,
>                unsigned int *total_len)
>  {
> -       struct smb2_pdu *spdu = (struct smb2_pdu *)buf;
> +       struct smb2_pdu *spdu = buf;

There would seem to be not much point to this (the original cast), since
the type is immediately explicit in the variable declaration.

It would also make for tiresome editing if the type should change, and it
reduces readability by adding a lot of characters that don't give useful
information.

julia
