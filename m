Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5941C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 01:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344601AbiETBuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 21:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344588AbiETBuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:50:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D788BDFF5B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:50:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ob14-20020a17090b390e00b001dff2a43f8cso646591pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bSYkUjPvAsu074e/VjNGWfjNftItgD9OU7BKxmchNu0=;
        b=IctWEQwULe+HOgPbU7d0NJ3bNOOh3R/ed9A6ET0Gs/piG+Bes/Utvzo/JOuyGD8RRU
         RcDWQ8n8fK3gVNdg7zOFFUdQGbLx/Yeu4mzOrLYeaNU76aARYW0jjqtvRRXuDmBVfrna
         g7qU8icOdLj7kU6hSvSdtAKN4mYIBgh28Dejc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bSYkUjPvAsu074e/VjNGWfjNftItgD9OU7BKxmchNu0=;
        b=62vjablt/+2rQBGzmGDyEZPuCaAUP8DeNd0b2dQHzmC0Lp4i3qNmJc91IDHUdbH1B/
         JxAvvC+G7uL51nvGvtxEw997bZgHR6pVXHNy6Jr0/gyLHVi5NA1gBP5a6TU51dRuk0wS
         hc/wM1l1mLS7qXfCB46dI2sKVLRY3RNO1WoarqAXUDLzvfxI3KcPuYLDTqHWPmu/IjgV
         urDQA5zUqMAWwN1FX8Ziq4myzOO86xB78FcQiVd0HYkCNyCP9/ueeGSeJScFMWVCfxpT
         dMI6JJqhHUMcTNhmA1X0XQEx8Q2NjO9b1gbs16p02oSeMhcfc1I1axbuMwUz9NGE6OfI
         AVAg==
X-Gm-Message-State: AOAM532NWDGdXtBjbe1saR9Xgp403sj1JC82qD0/a1iU1oept/ruFH6H
        WtEmKppK1Kxhg9iejySQ1QPpxQ==
X-Google-Smtp-Source: ABdhPJxYCaKfJrQpyhnMwy4bw/c5zkQ+q174lh8wbUasjk9l4ZAUxrQCXZ8SzukBnlB3+yq5G+ayIg==
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id s7-20020a170902988700b001516e1c7082mr7427960plp.162.1653011400364;
        Thu, 19 May 2022 18:50:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a23-20020a056a001d1700b0050dc76281ddsm329776pfx.183.2022.05.19.18.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 18:50:00 -0700 (PDT)
Date:   Thu, 19 May 2022 18:49:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     ilkos@google.com, tjmercier@google.com, surenb@google.com,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Colin Cross <ccross@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC PATCH] procfs: Add file path and size to /proc/<pid>/fdinfo
Message-ID: <202205191848.DEE05F6@keescook>
References: <20220519214021.3572840-1-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519214021.3572840-1-kaleshsingh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 02:40:15PM -0700, Kalesh Singh wrote:
> [...]
> +	seq_file_path(m, file, "\n");
> +	seq_putc(m, '\n');
>  
>  	/* show_fd_locks() never deferences files so a stale value is safe */
>  	show_fd_locks(m, file, files);

This comment implies "file" might be stale? Does that mean anything for
the above seq_file_path()?

-- 
Kees Cook
