Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DD5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 20:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385876AbiEEUfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 16:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384978AbiEEUe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:34:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A015F8EA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:31:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d15so829348lfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 13:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzJXnZ7chU1+5zJp4Dgvp3VaPPi5u4rVhagYP/eqQQE=;
        b=GcsLNO3ybt8b4qYioRwjRsGo24/f0OAD/JE388Gc5emmRyTIhlyYUbKzIgZyv53hb1
         xhiVCmKW0WOkPCvBf1e4g28vMmUQUkmrVh+o51YOtKO8cBVzloYHCXntPyZO/l8A9u4M
         5CxbT9nvJ8k+TaFHNOPLcGCSi7HogLmrn63TqdbSnLG4WHsAsFmI3EppXVPekhAxB05a
         NEbtgx7QVCxIiRy2eSQmkdwO62yYlPePGIiYe39mbWzh5zAEXFGIG2orgZSXN6r69srE
         z8JRd8pqir9+V0J5tZrITxsJOR+WTOS0fPBTlN8HA0KMIdLI2QtAq3P5nFh0k988K2Jw
         qG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzJXnZ7chU1+5zJp4Dgvp3VaPPi5u4rVhagYP/eqQQE=;
        b=76TfoIo6t6fxLOOgDcyAayxTaSpfSS6QWVzKmp81fNNcY7OckjoZR+4TOKt1H1qNyw
         ehet1/hgrn6wflwRGo5ZgV+ho3AufNTyxx4xykhBYRIBUy7O43mUH0SS19zrXzqKFw23
         SZdJjtdzhpxKUDRX4GtyzBRZel1xNJHlFe8I8RKFl83fALDycen9a+T20akSa0r69Crg
         CVibjTTGbLT9XjmV+L8VR6/pMHCc4+ax4oWQHKART0VVsV9Tx/s3Sj1yNdGiDiJdFqvl
         Jt5URuzJSv1H3K+V1bXPHIyXc8/GoX/pM5xqjOYLZyQ6fhuqPKOi3JN3rdv5sO2bkr6+
         7IAQ==
X-Gm-Message-State: AOAM53398cLJbqzt4rfKvtSANRCY/cZgG1PF14QTuTHVHALmDaMgfvEt
        ZI7yXWT3FMGKWUnG1R7+rA0jyImKTp8+9ALh9IBYjA==
X-Google-Smtp-Source: ABdhPJwbhs3kr3NEQrD1kb2FM5lFdKjT3Fw4s9E6Bf+BV+NG8NhQY5rDLxGeb5Ices7vG2JpejLiHgrpcihMdzG04I8=
X-Received: by 2002:ac2:5e86:0:b0:473:d044:60f5 with SMTP id
 b6-20020ac25e86000000b00473d04460f5mr49308lfq.87.1651782674718; Thu, 05 May
 2022 13:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220505072244.1155033-1-masahiroy@kernel.org> <20220505072244.1155033-15-masahiroy@kernel.org>
In-Reply-To: <20220505072244.1155033-15-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 5 May 2022 13:31:03 -0700
Message-ID: <CAKwvOdkTOv1VZti3KH9zxXT1xceogUPxdCV1JqoYbTKtdUy0qw@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] kbuild: make built-in.a rule robust against too
 long argument error
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Nicolas Schier a <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 12:25 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Kbuild runs at the top of objtree instead of changing the working
> directory to subdirectories. I think this design is nice overall but
> some commands have a scapability issue.

s/scapability/scalability/


-- 
Thanks,
~Nick Desaulniers
