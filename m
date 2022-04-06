Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B174AC433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 12:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiDFMWE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiDFMVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:21:10 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F2611145
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:59:57 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id t19so3103940qtc.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 00:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZ3i8hOWoPD/aW6NhArIcWjIwd7zrVT3uWNX2SKdkr4=;
        b=JfBbSURjSzum5lRmLzDLcPn0iZV2kG0yUFVSz95vhsqWIibE2h2Xi2ToSkHj3BOhw6
         1Ty5l+o+Mlso41qlizOrFjwZYs+kImbwTfcUvV5YY9ii7dAr0jzjJp6sOEMnz1OIXJsy
         Cnm+s4XNHwJwDCxQJIb1VuS3k3YkVut13xu12mc7wx2gqsFxdobwL8UxKfGwdHCSTSJ/
         TgkN+eNbm4dAoD7hF9gfQzgDsPfpYnsXDhhIG/99DlXxNvSES1FrhJhgBPddBUnHcLCX
         +W+Uio/4/WrJ5Km6ntpgYoD3gZhFOt7im5mDo5tlTvJ/E3p26LFI0GSfBpjCLECHapxJ
         7H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZ3i8hOWoPD/aW6NhArIcWjIwd7zrVT3uWNX2SKdkr4=;
        b=b+VmHvPtc9q9ZmbSC8LNRQp2lCu0HuCwxewPkvdCqKMCzUTLbjzZRcZbH4FmjUO910
         HO+9AXytg/ZFd8Q4mRwKJPauthU4McMs/M7cVd82NIHWvLUpgWVxezM4+ebYvYjIR+3B
         VeUP4ywVNJa6B4hJxGEWg1L2ghg0p7i5l2gPBbMLXSQy4zoMV8TQqXLmzuthdyU5y9kJ
         wKl49RISuF/7Ma82NG/Y0gSW5HjdMYuCZ3MOsegD2/+VVPYeJyDAeg531UX5DSoY0hGI
         UorzEZbArznRt2Fru73hQM2YWNEjpaR0MII3A3J0cps1iE+pRznT3eqOovT4qC7xBCKm
         Y9Nw==
X-Gm-Message-State: AOAM530idZpc+TKXSXjcLrcmSDPwBr6/3DSgIVsNrivGbTD795/DfuPT
        6cm+TUpTNVP4oqfOayiLmtQ=
X-Google-Smtp-Source: ABdhPJwDEcdvvvS199I56u0w697cF8AqbvxftijXUZmXKhcWXsqlHfeYDE0QM9XdAgsz0Yo2SX4Gng==
X-Received: by 2002:a37:67c6:0:b0:67b:1153:a63a with SMTP id b189-20020a3767c6000000b0067b1153a63amr4639464qkc.695.1649231997091;
        Wed, 06 Apr 2022 00:59:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t7-20020a05622a148700b002eba7850c57sm10831888qtx.21.2022.04.06.00.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 00:59:56 -0700 (PDT)
From:   cgel.zte@gmail.com
To:     christian.brauner@ubuntu.com
Cc:     cgel.zte@gmail.com, dbueso@suse.de, jamorris@linux.microsoft.com,
        keescook@chromium.org, ktkhai@virtuozzo.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn,
        varad.gautam@suse.com
Subject: Re: [PATCH V2] ipc: add set_ownership() and permissions() callbacks for posix mqueue sysctl
Date:   Wed,  6 Apr 2022 07:59:50 +0000
Message-Id: <20220406075950.2488558-1-cgel.zte@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201125314.mhx7z4nhg2ei2eof@wittgenstein>
References: <20211201125314.mhx7z4nhg2ei2eof@wittgenstein>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christian.

This is a polite question:
how's this patch? It seems that it hasn't been merged into linux-next so far
