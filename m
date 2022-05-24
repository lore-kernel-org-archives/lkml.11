Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AF9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 20:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbiEXUoY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 16:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbiEXUoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:44:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B019712E6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:44:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id br17so20484793lfb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=huOMfVzBuyOiVvdK/MBgTa5e2DlFi34FRjwinoAWhQw=;
        b=Leyfu+q2cQs4X+VAh9p7WyspRKKN9AajJaaq7iBUfrbCZulu0O4xpeTE64b8HnVfG8
         j/21YiT8ew0xb5w01SCrsWNkESNi62Og5SzruUCLHoUEkglIUoB4dCF1/rMrQUFEVFqL
         zI2gv8ybJRlKj051tfrHUr+1fF000YOYKH2XO1pp2yI+OMvZTee/FlRkkfu9QNPnI8Dv
         +ifzCPUHnbEoPVNJffqxyJRbUXQenKiIbmUQyMegTUxdBQkJdjn+5pIgCnAwW138HSic
         mfrUEeFSwJEFxT91eV2+vK8MmB1H6ek/Fhh6EehALQIfVbWZUjW4al+SabsE1u/vw2hw
         1sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huOMfVzBuyOiVvdK/MBgTa5e2DlFi34FRjwinoAWhQw=;
        b=vro2LFnVqJM0v2UN9RfbcAtaSpclfJZEkQWuboC7AyGjlf/yi6w+nEGmO46LRNq3Ls
         UyD+LHNuwX7LTrukpf81a0+6yxjJ3Sn8JLg5+53qN1h5rpU+KjnUp18OEkR7piH7frEc
         oh5eLSsgGhQ/0pe0v6iAVklgKz3dVaPS+leqXADCUbHIk80YOZPS8uMh5fqpzqeWzuEv
         PgggVHk8agRNkZ545EsS78+3O5sZ3guVrfpYIh9ILF5iGfm5jx+4egk2E2+cxsPw9SZt
         Uqsbohx54OoXje9bMSFllj/Ufr0WjSSff26b5vcJZaxd2Zwv/57HW2ifPHCNmKLKUDVp
         yyxA==
X-Gm-Message-State: AOAM530mOBJI+nxG52f502ssQJmRq1bCv/voKTbkyOAzvhw4Xi19TL9X
        9XHPoRMOdIuptUPLSe40UIJ7n7Spzlb4G08loS/XfQ==
X-Google-Smtp-Source: ABdhPJy6wop+fJ1n1TfLcrlKDthzTmtCj1Moa3LBd4CNE7whT6h8sZrF+BORjFxjY5h93F1+C9hs16t8wpGpStygs7s=
X-Received: by 2002:a05:6512:ace:b0:478:9af3:d9cb with SMTP id
 n14-20020a0565120ace00b004789af3d9cbmr1122823lfu.103.1653425058264; Tue, 24
 May 2022 13:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220523164626.858340-1-masahiroy@kernel.org> <20220523164626.858340-2-masahiroy@kernel.org>
In-Reply-To: <20220523164626.858340-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 May 2022 13:44:07 -0700
Message-ID: <CAKwvOd=fZ=V52fOc47O1=0wy36b8q_LO54J0099_GkouzH0SZA@mail.gmail.com>
Subject: Re: [PATCH 2/5] modpost: remove the unused argument of check_sec_ref()
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 9:48 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> check_sec_ref() does not use the first parameter 'mod'.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Perhaps we could enable some -W flags for scripts/mod/?
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 845bc438ca49..843c64eebe8b 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1883,8 +1883,7 @@ static void section_rel(const char *modname, struct elf_info *elf,
>   * to find all references to a section that reference a section that will
>   * be discarded and warns about it.
>   **/
> -static void check_sec_ref(struct module *mod, const char *modname,
> -                         struct elf_info *elf)
> +static void check_sec_ref(const char *modname, struct elf_info *elf)
>  {
>         int i;
>         Elf_Shdr *sechdrs = elf->sechdrs;
> @@ -2069,7 +2068,7 @@ static void read_symbols(const char *modname)
>                                              sym_get_data(&info, sym));
>         }
>
> -       check_sec_ref(mod, modname, &info);
> +       check_sec_ref(modname, &info);
>
>         if (!mod->is_vmlinux) {
>                 version = get_modinfo(&info, "version");
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
