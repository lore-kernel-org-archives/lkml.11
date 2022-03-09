Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC24C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 22:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbiCIWkL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 17:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiCIWkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:40:09 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B38119F06
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:39:09 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o23so3120048pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qPulFl9nhnnxBesMXec7Lkd6SHxDuJG6b9QC9Z6RVLo=;
        b=a99/adhsSslenJCyW+OxS6N1+x1TiBVomEqesa1k+FQaoGcwtEhZw741FqvNuWKtuy
         r647NGwGN5/RPizlR+UDAQFQeA7HIayrpXdAlXMjG2uNNR9BQQm+Zg7ZmkMXlRs0neTx
         /AG29sai3C5P3xtxpB39wD/x/viVc1b0snFpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qPulFl9nhnnxBesMXec7Lkd6SHxDuJG6b9QC9Z6RVLo=;
        b=4SeQEwYuipkvegA89NOlInZNX5FRLVNz5zyg/3ucUqrTIJ4swxSyQEqaHmFsBZLd72
         JKAwYbjHICiNP9A41VHawfYpTgUrudq4Vhz0wa/mL8LlFiQK1TFTICbpgK1kredyCQsF
         Qz+d6AFqPYMkc3JmsXOMSfwb0fnwKriRgR4LRrcRd32Y0cgGtIsi9KQ5uMLYxlyWn8rr
         s5inuKXR6yw/2NnuN2+flabXscWIWQtdAc0Ul1G+Njlje1oEeOLLKA/+e/S46xp1Z+tF
         VzIYxvilkRCuyKOsjGL+wXn+D6Ln5YbkwOa1Y2UMFVygcZS+7y9DZGhSwCdJubqoACAO
         Dacw==
X-Gm-Message-State: AOAM5302pgdUMKn+TuYPeM2/lkXp5M3pZtDYCS2YXe8vLY0M8iyROAnF
        DwQOVR+NbKc6ZLVgGvwblA/ajg==
X-Google-Smtp-Source: ABdhPJxEp67NJ7rJ6/ZoT0r5ZN5qIlpeejtLCP3K7aGcFEmudLc2G+1Tp17iUBh+zquoi6+alG6nFQ==
X-Received: by 2002:a05:6a00:1248:b0:4f7:db0:4204 with SMTP id u8-20020a056a00124800b004f70db04204mr1717656pfi.27.1646865549219;
        Wed, 09 Mar 2022 14:39:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l17-20020a056a0016d100b004c34686e322sm4397990pfc.182.2022.03.09.14.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:39:08 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:39:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 11/13] resume_user_mode: Remove #ifdef TIF_NOTIFY_RESUME
 in set_notify_resume
Message-ID: <202203091439.99A02455B@keescook>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-11-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309162454.123006-11-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:24:52AM -0600, Eric W. Biederman wrote:
> Every architecture defines TIF_NOTIFY_RESUME so remove the unnecessary
> ifdef.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
