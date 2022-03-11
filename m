Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EA4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 22:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiCKWxj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiCKWwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:52:39 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5862776AE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:30:29 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id c4so5430626vkq.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgoWWN4hCZyheZL5Lpc6F+SOSSfbZr+cmTie+FjLL/U=;
        b=mtZIDQzI4w//KeWsJ2nREBRH48vSl8kYr4h6KnIe5cSL9HdR1uL1d2bNyoM0PZOzzw
         haxsrBtRb50oLszHGuDm4wP0mFzjTuj6eU5mK/YlsBIdTacrztfsSa2dZjq/F22ftdf/
         Ab2B5xTbjsD9TjWdiEZ13yf6BPF0wsH2hEAXH97meu5+HdWshInu+w8KECW4kWfbVGWz
         vX+TikxSASI1HD9Hq/eZv9xIrOZBlPbEM2mCQGYpCUVvDqraEr408jrdz+RmxOCVO7uu
         y7/Y27NTTBCn1y/5V+KIa+om8njF4ssjv71xBVaRmfzwOyMG5i4yLZBZJx4wW4CuzUDu
         iX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgoWWN4hCZyheZL5Lpc6F+SOSSfbZr+cmTie+FjLL/U=;
        b=aHjRQf/DvoTMMEHK+jADLwPkyRTTuLmUguoMuK5zVI3VStL1CnGetuDOtJaBwgcUdv
         hH/2SxIPRHdqZNlYvXft4SxESutHjBbxOyLNWmLavwVeyowde5lMf7LTNYqU97v/iVMR
         niwWfI6sMQLrP5eI1EuO5Sf994ab4ihqIWKRG76rTLrHqpqlWmx7asAoFa2A6BO9JIZr
         HAauhzBaQa6tsqMM/aM5b4hsaHunLFUyT4AyL7KZqdOXRuw6OsmTxI9JWIr3ubRYcXSi
         jtOeETxs7EvckDKpmWsg7RlwaE8wCRJuVuqP2nwQsA4ID0CU0rdGz20oK0OE84JudsdA
         zc6w==
X-Gm-Message-State: AOAM531OUUcLkgls3mqfotCPJZuHfi28BtbwB51p+pDXLBmlxahCI4Pk
        qyLAbIqJtxrFbwVhiuocLhf49bg6Aysit8DSitMnYg==
X-Google-Smtp-Source: ABdhPJx9tE2Kubv2Fs9EUFi1p9vKnotywBkb0W4tg339TVlhtA1C3NOlV0UI5eOnfiIJHug6YMriDbGtX8klgeeMdaw=
X-Received: by 2002:a05:6122:887:b0:332:699e:7e67 with SMTP id
 7-20020a056122088700b00332699e7e67mr5861257vkf.35.1647037828452; Fri, 11 Mar
 2022 14:30:28 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
In-Reply-To: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 11 Mar 2022 15:30:17 -0700
Message-ID: <CAOUHufb=GQaX_2Bp2YfY4ntBZj8iwb8z9mvxUFXw+KkySRu+KA@mail.gmail.com>
Subject: Re: zram corruption due to uninitialized do_swap_page fault
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 12:52 PM Ivan Babrou <ivan@cloudflare.com> wrote:
>
> Hello,
>
> We're looking into using zram, but unfortunately we ran into some
> corruption issues.

Kernel version(s) please?
