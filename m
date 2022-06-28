Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7109EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 20:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiF1UVo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 16:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiF1UVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:21:20 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CEF3CA7D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:18:45 -0700 (PDT)
Date:   Tue, 28 Jun 2022 20:18:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tmb.nu;
        s=protonmail; t=1656447523; x=1656706723;
        bh=ctnoSDpkAjzz//locm0Ami/0y0//adMs+21B++bI/PU=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=vgZ4FCOUmUZ4yyFWreFS5pB7A6lsdsC2wFgKiwJ5MdhosNlm/tUneEQO1jwilrSzI
         QONEgCX8uVq7G7ZFFzfpXr+FRukbUDkjcW/q7SBCFFABorck2KKFwJvnrC9AJNjIeu
         GFL5FNFuhC9jOeRWZHflLl/S5BEfLKwcQfSMx+RU=
To:     Ronald Warsow <rwarsow@gmx.de>, linux-kernel@vger.kernel.org
From:   Thomas Backlund <tmb@tmb.nu>
Cc:     stable@vger.kernel.org
Reply-To: Thomas Backlund <tmb@tmb.nu>
Subject: Re: [PATCH 5.18 000/181] 5.18.8-rc1 review
Message-ID: <f0cdac2a-79f3-af1c-eac9-698b0c8196a3@tmb.nu>
Feedback-ID: 19711308:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den 2022-06-27 kl. 19:38, skrev Ronald Warsow:
> hallo Greg
>
> 5.18.8-rc1
>
> compiles (see [1]), boots and runs here on x86_64
> (Intel i5-11400, Fedora 36)
>
> [1]
> a regression against 5.18.7:
>
> ...
>
> LD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmlinux.o
>  =C2=A0 MODPOST vmlinux.symvers
> WARNING: modpost: vmlinux.o(___ksymtab_gpl+tick_nohz_full_setup+0x0):
> Section mismatch in reference from the variable
> __ksymtab_tick_nohz_full_setup to the function
> .init.text:tick_nohz_full_setup()
> The symbol tick_nohz_full_setup is exported and annotated __init
> Fix this by removing the __init annotation of tick_nohz_full_setup or
> drop the export.


Should be fixed by:


 From 2390095113e98fc52fffe35c5206d30d9efe3f78 Mon Sep 17 00:00:00 2001
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 27 Jun 2022 12:22:09 +0900
Subject: [PATCH] tick/nohz: unexport __init-annotated tick_nohz_full_setup(=
)

--
Thomas

