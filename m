Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B0DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 19:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbiEPTIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 15:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiEPTIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:08:41 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0DF39164
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:08:41 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id dm17so3947307qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWhuSwJ1k6HUpGLnD2KZPbkFRnPK5pZaeOwgp6ocvUQ=;
        b=Cg7RLNiUvMpwSqS52vzZr3wCjLHtOYPis74p3myx73AJzSpif89nUgrKcHtYiCwEQG
         AZEms7Vdrb0iq+RhVIWFYwYJOzygMkcDirDYhZ6X7kKPyyvFABqV90LHXFOh1fTotcN0
         ptfNCac6kOciXfSNzbxtJKTZeXkvazIhvQAIcSY82q9+cHCzczJEw4keUEHl6KmW3CCn
         11+wsoX2VRO8Jwc34ZgusdJgCC112nQyOXezBln7A6y4JmovpC59vhA6MHeSB4DOL55n
         V3rGns77tU1GtVuIyo49A4cx5dCMhFAUDilet6zxR4rSXgPnCZDjdH7dZQOGVwgEPxEU
         SH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWhuSwJ1k6HUpGLnD2KZPbkFRnPK5pZaeOwgp6ocvUQ=;
        b=RTacMMiixDtTHSi7ZKf2hsViDWSsWDUV/2Ba61Vwftx52w0wnpKeBzpVweCUt+GnFS
         89cNAoQNeVD7D91ZxWEypBEdITTP8/juJyI7ktPEg6QOJUgLfwTiuJQvB2NPqmGNO6r9
         DID7V8VKiyGlhLGgAoND3S5IzO0w0UP8AlO3qdioey1V8Szz0LiolHLLfCx766DbmouS
         ssGwRr6s7d7s2h3D11lyFagzwth3V1XFh8m1MrkNWk8ecajRfx1Fb4RnKo3b9YTK36wq
         U/NodcBDVD6EGia6FwBtBUmKrE2gkfwwQQ1mC78yOtJvWOLlLy4GSocCoYJMsiNIPH96
         GeYA==
X-Gm-Message-State: AOAM533n7vx0zx6XAI+JoIOblhvIWUU9OQtQdHw9yaAr17y1ZqUoN00c
        GIvCDOJ4R3hXJUqetJsk4JrApe1V97JFjTjGz0sCUu2UdSY=
X-Google-Smtp-Source: ABdhPJwLQgKuHGP4v3UTVYu0rmSD1z1cvEF8y/Yvzp9dGSDjpnes1BwVXkyrqWIwzHVGCM7O4O5ODcxZ/OMnkwceK04=
X-Received: by 2002:a05:6214:202f:b0:432:4810:1b34 with SMTP id
 15-20020a056214202f00b0043248101b34mr16674186qvf.35.1652728119973; Mon, 16
 May 2022 12:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220516182859.3131675-1-haoluo@google.com> <YoKa6CLLF25xx6QX@slm.duckdns.org>
In-Reply-To: <YoKa6CLLF25xx6QX@slm.duckdns.org>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 16 May 2022 12:08:29 -0700
Message-ID: <CA+khW7jwDE0OvvJ=WoEMJGNLh+z8FG9iZcpGv7eMCaEyNLmfvw@mail.gmail.com>
Subject: Re: [PATCH] kernfs: Separate kernfs_pr_cont_buf and rename_lock.
To:     Tejun Heo <tj@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:41 AM Tejun Heo <tj@kernel.org> wrote:
>
> Can you please add a comment explaining why the lock is separate? Other than
> that:
>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> Thanks.

Sure, will do and resend.

>
> --
> tejun
