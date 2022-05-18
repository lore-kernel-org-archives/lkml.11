Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B902C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 01:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiERB1U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 21:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiERB1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:27:18 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0C649F3E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:27:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i8so367108plr.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jygthAMJFjFeeRpTDr7egf+IhNfU+oRkezUzyZc30HM=;
        b=ilWIqd0QmC6KdbTWF/ZzbZeKmKYuiqQQI3VF0dZx13RfOc546giG1pbHtfF4TT3lsH
         Dj+qewwGjj1VLE4mnH+Dz+JFMeB02NyYj6Fwre5BBClDpnkukcLfrpZmsMPO5cHDPVRF
         6jqM0NJJNJCZmt17HDk6PvgqSDDiVYrG6bIlXghwZOZvnI8/wgRKKGf5bU2wgZ/QZ5oz
         RzcIQw4n6aIuChjVTMUuPOiLOe6Z4SHWnoRhcsK1TIh0Hz5epxqOTgO4YU+UY4H5n14W
         P7aa+oaIYFeecMSwUzibcn1HKZ1QQjaRTtUv9gJV8cWXyUxRGWCs01f/5xYlFLXPZqwJ
         Z6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jygthAMJFjFeeRpTDr7egf+IhNfU+oRkezUzyZc30HM=;
        b=KrYk6ITNPS4aXgzTazmMfoJDRnveIqbarr7Llf16yPTlbvth/GTPbOlK6tOgW4u5dx
         VhWQSyPFJIB039LkCgevLl1ZkQ7Jgw188TaUihkmLE9/klLb3jnzRpmMfbIaamcnca4V
         PIrUwsPMOsiewzXsdVn9MPwvzd2mnLjQjDxl93gKHvJl0V214p2cLEvS4UXDfSrisaZ5
         j6RLTSKZbcv4CTlUr3SGyRaQOjnqaAu3skTte8x/e0NnTXtcJ2NzqfbVwS86digwbYVc
         TY7faR+pZf643gAkq5V1zxX+EC3WbGYbymQ9oawxYYt5vel0451rX3wZkKH3DlHFAJda
         bLlQ==
X-Gm-Message-State: AOAM530S6YITWiLe3c7c6TP/qXjfm2o17vMUnUu6LeLBbtVnkRpuV8Am
        0S5LfMsz8HT09cQdBn6gZscajg==
X-Google-Smtp-Source: ABdhPJwX0rg1E0rLT1mV/McGEA9m/AoNV8A6q3F1h1hLlgBXdCLI1HnaW8O57OIJQp+PjRFnbBJfMQ==
X-Received: by 2002:a17:902:74c5:b0:161:5061:9d93 with SMTP id f5-20020a17090274c500b0016150619d93mr18122182plt.171.1652837236896;
        Tue, 17 May 2022 18:27:16 -0700 (PDT)
Received: from google.com (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709027e0700b0015e8d4eb2d8sm224850plm.290.2022.05.17.18.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 18:27:16 -0700 (PDT)
Date:   Wed, 18 May 2022 01:27:13 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Schspa Shi <schspa@gmail.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        hridya@google.com, surenb@google.com, linux-kernel@vger.kernel.org,
        syzbot+46fff6434a7f968ecb39@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] binder: fix atomic sleep when get extended error
Message-ID: <YoRLcfSC//FZn1UI@google.com>
References: <20220518011754.49348-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518011754.49348-1-schspa@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 09:17:54AM +0800, Schspa Shi wrote:
> binder_inner_proc_lock(thread->proc) is a spin lock, copy_to_user can't
> be called with in this lock.
> 
> Copy it as a local variable to fix it.
> 
> Reported-by: syzbot+46fff6434a7f968ecb39@syzkaller.appspotmail.com
> Fixes: bd32889e841c ("binder: add BINDER_GET_EXTENDED_ERROR ioctl")
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> 
> ---
> 
> Changelog:
> v1 -> v2:
>         - Remove the retry as Carlos Llamas adviced.
>         - Use binder_set_extended_error to reset the error info.
> ---

LGTM, thanks.

Reviewed-by: Carlos Llamas <cmllamas@google.com>

--
Carlos Llamas
