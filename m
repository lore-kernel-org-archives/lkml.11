Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051A3C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 05:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348968AbiDOFlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 01:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347121AbiDOFlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:41:01 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C239F6E9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:38:34 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g11so6067323qke.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S0JX2UJMXFJ7vWd7QOLm7QlLBIehu8n8ur6LpthHyuk=;
        b=PAWHnAqPsyCcG1qlrEVvUy3aN7mTVcpIwT8zBzAtZWADIgCqfMCsSmcpwkVfPFfbTP
         K4Wil+4b/vHH0BC5E4iKylZK/hGNX/SysArA0xP1rUCpnUK4F8khXcoe3x4x/FDjg3Ol
         fiTRMZEqPrlBPkmK186UYCp8oP9Y2k1mwwD9CfFU51neTTW8dYRWb9sJxYCLJ9EEPfQM
         eThs/azPCji4DbDre81oMTMsGnJ8hpNGuH0pL7XLr4j8ZHAUbGHxBqedFqoF0GUBeR1f
         mF5gq60UAyKLXxZ7PikygQv6v0YEJcFzANcqELnGDieirYX4K/eHDqur/iXL3giBcVzX
         awfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S0JX2UJMXFJ7vWd7QOLm7QlLBIehu8n8ur6LpthHyuk=;
        b=yVQF3bp2eg9cgNWVC4y32cUAQBkMxYjIzs8+ci2ypmrX5EBlvRWPSoudlB3tY4qxYS
         ZW9BHjaBIypicTtWuCFe8DjMFdn27LvB+Vfhswetj084oHzZcF/ngiM3N3Y9mnXVY5uz
         kM4oJY25jQxAGUxS6meAFbX6wmyhqALyxZ2FQG9L/ErRfS3OJaZKjL5pxKpgxlfKdtMq
         XlkBNXPn87A7lll7dc3QrvBphGkDpeXKUz8hAJMteO2LGUZqq97Gc9uizn55VDFmWxGs
         Yz5FseD7bnj0FTYL5Lappmeyc9IGErC6zqJEcDDSjTkZx/91DGeUwZq3LaJxk2IoJi7N
         IILw==
X-Gm-Message-State: AOAM532BLFHRl2lb4jkhjLr7nOBFw1zURZLQXVlDHvt8pVelxqsFx89w
        fDOLN4T/h1ZoTfNgQA+LKGRS/K/N7+rgII8wK80=
X-Google-Smtp-Source: ABdhPJzhuudtkv6ny1zJHXnJ9IMTpvX7zf9wzg2zNTjJtCoOG/WGrnaXgSmsW6Oi3Nib0+NZePC7EHE946v0pbbduSk=
X-Received: by 2002:a05:620a:4491:b0:67d:9929:ddb6 with SMTP id
 x17-20020a05620a449100b0067d9929ddb6mr4425320qkp.47.1650001113554; Thu, 14
 Apr 2022 22:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com> <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com> <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
 <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com> <CABXGCsNNwEjo_dvWJL7GLULBPy+RmwsC9ObpowR_M1nQ3fKt3g@mail.gmail.com>
 <4d0cbb79-4955-a3ed-4aa2-7f6cdaa00481@gmail.com>
In-Reply-To: <4d0cbb79-4955-a3ed-4aa2-7f6cdaa00481@gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 15 Apr 2022 10:38:22 +0500
Message-ID: <CABXGCsP19VFRgTx5yGn68iCK3NxPxi_b9MTq=AmHtFPv9xR5sA@mail.gmail.com>
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at drivers/dma-buf/dma-fence-array.c:191
 dma_fence_array_create+0x101/0x120" and some games stopped working.
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        thomas.hellstrom@linux.intel.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>, Ken.Xue@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 7:27 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> That's unfortunately not the end of the story.
>
> This is fixing your problem, but reintroducing the original problem that
> we call the syncobj with a lock held which can crash badly as well.
>
> Going to take a closer look on Monday. I hope you can test a few more
> patches to help narrow down what's actually going wrong here.
>
> Thanks,
> Christian.
>

Hi Christian.
I'm sorry to trouble you.
Have you forgotten about this issue?

--=20
Best Regards,
Mike Gavrilov.
