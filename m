Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BACC433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 12:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbiBWM4W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbiBWM4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:56:20 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5574BA41AE;
        Wed, 23 Feb 2022 04:55:53 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gb39so52349454ejc.1;
        Wed, 23 Feb 2022 04:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kScADH37OaRYlYEouQtZu5Ct7rmTJHi0Bet35ccCJNo=;
        b=aF7itRK88PovkGNak7KWgkct8NosmYkciBGGyP6k91f/DtbjKFiDc73uy6LvZzMcfG
         uluu/mqFMfZThidjFmgJ7nKxugfFCKz10PDjjQKXPH1NAcMGBuhcYV5R5Y55HxxIKEqv
         R+ZPiPlQDDY58jY8vRiHbmCcgpznYS8LcaktGiAEkYt06njQTHTj5FP7cJrxsftjehBD
         Zff8F2Q+gbW/vrEi741PfsehQYqZ3YIGUZ0ARcaw5aLvYueqYqncNSdYVK5KzcqP+Jqd
         UkoUg6Lv8jNaMA4DYe4yt6c+ntCGHu9j3CiZRwqfwb12oFdTI4DgCuqVpJv+AFyKcI9T
         05lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kScADH37OaRYlYEouQtZu5Ct7rmTJHi0Bet35ccCJNo=;
        b=2tJspQAmv8spszPOYiwOy4pGGInOJ4jHZ/1IzrBK+/1PR8VVaJ1xZGJD7V9ZEiQJ8j
         ZZd8CpxXNp8DhELy/BGxOcWWb8Q2LfjFQw9YD798hnyHKG1vqF2F99fY4deDe0Q9JJJQ
         8M+N5PUD4obMSsUq8t6Z7CNQjSD0+3nvCkvHetpE4JvuuKHcDAEeFbMijW8wu2M3Tdua
         172DYdm/gdoDaWG/3aZTJbM5nOsRoYRG9p2+yEmdmmEK3C7/ybL4h2fOzdNyf5ZHOxf4
         xkE4qfKxOMUhFJivfSfkIeBGFBHeaPlrskhowvO8WG6+4GnimNgZ4onT2Uz31Xi2JPp9
         79/w==
X-Gm-Message-State: AOAM5313K666ekEvCEylXIiokndxBvraZZgqb633SwPUXAutggdyZHbN
        2v1p2lStHufXIktpIZuY6QY=
X-Google-Smtp-Source: ABdhPJxGmnIY9fKDkAoalOGRzaG+w97YXUaHlIBuJVsu5JF1QhA8PoxZs/Ckb21YhW02JIe1skpvpA==
X-Received: by 2002:a17:906:9454:b0:6b5:aa6:2822 with SMTP id z20-20020a170906945400b006b50aa62822mr21863909ejx.619.1645620951808;
        Wed, 23 Feb 2022 04:55:51 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id l9sm5877407eds.9.2022.02.23.04.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 04:55:51 -0800 (PST)
Date:   Wed, 23 Feb 2022 13:55:48 +0100
From:   Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tomasz.warniello@gmail.com
Subject: Re: [PATCH v4 00/11] Transform documentation into POD
Message-ID: <20220223135548.27babd85@fuji.fritz.box>
In-Reply-To: <939ef119-8a84-9206-bd7c-cfd215bb0200@gmail.com>
References: <525f3696-91f4-5a4a-c9ef-24758ccaa2bb@infradead.org>
        <ff98f455-0221-7ff0-08ed-8dea9f08694b@gmail.com>
        <939ef119-8a84-9206-bd7c-cfd215bb0200@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akira,

Take a look at `man perl` and you will find a synopsis also. It's simply
better in depicting grammar relations than a flat switch list. Especially
when the grammar gets complex. I dislike it also. And I don't think it
looks good. Rather creepy and overwhelming.

> > I don't see much point for such a non-user-facing script having nice-looking
> > well-structured documentation in the first place.

You're touching the very essence of kernel-doc here. What and who is it for?
Not just the script - all of it.

Regards,

Tomasz
