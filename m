Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35102C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 13:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiB1Nhm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 08:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiB1Nhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:37:40 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E075C10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:37:02 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso14802310pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=9O/Lni+iqGcrkwxA9DWmuMqoLhFH+SpOfK8UNsywB74=;
        b=rfF4O0RCWIfKvhyf5N7suLWZt2W55bwAcXDHa+lMQfsT9iHbp8rUP11PkuqHCXG7wa
         zU/7k7NZhQg8Qginfi8CPkY4+hJ9QFSUQfQDDCAfTVNx/7YA0OwKYvcKVI1K9174xjZz
         rO0fMS2fksY9ntODzv2V00kQB8emJKKOZaSrfa6G/xG762sS27UmPqWAaP1iMHfxgB8/
         gxNKABKCL3NO8zpwtZxHcJy2YablfizBxJNsPn0MM1/HANTwsPUm6wuT0+dVf8M+ymqs
         7LM6NZqeAv9Q8R1gJWY/D8OJqmcA5rPKIIOhkRmeTXdWTO+oMMB0xZLhl+EaP8BC37Cj
         CjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=9O/Lni+iqGcrkwxA9DWmuMqoLhFH+SpOfK8UNsywB74=;
        b=XENtQW0bBiSc5vm8u/GsUOe9O1Yfcwmqgn7CG/SpRjTyDBCnj02FgQxmO0Y6U8zDEg
         TAf3jz7wle/09YzVbY/2yFKg+C/xOEfRBjDhYeWHPJsvShcwVb4XHELl85WtKKTuOr8V
         IHIERCst5ry36CdJ3V/rEmT84sg8/5GiOrMFJr4t+nr/2KFkN+73ZX5vzY//cf2r0X6k
         HlW9s/5M/RrklzWibLQE6bScEfhGBQgF/R/gv6cBv6NASsDpJ+Foz3nmKfJonr9rJzHz
         UWIWdAy2VYvNnOQf/ynVhiUuDEAsUwyGhxLwjuNeeKGRvYjw3Xupy4G/YCDcjRkjzh8A
         v8UQ==
X-Gm-Message-State: AOAM533jssHr1G/Hy2rN9aK3Fa4Qo8YpHmz02WKrGlg5cmPLd+GnFX0a
        hXCBlP3xGm3TOXCdLgPXZQbG32Mynom6rg==
X-Google-Smtp-Source: ABdhPJwJgTC7vwspU3jNtdfRXtNKV+8vWmMP8DO8GTRLIHPsSgiCUtX5kVHob8xNbWsMh6SzGrKXMg==
X-Received: by 2002:a17:90a:8689:b0:1bd:4c83:4c5c with SMTP id p9-20020a17090a868900b001bd4c834c5cmr5524100pjn.142.1646055421789;
        Mon, 28 Feb 2022 05:37:01 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u16-20020a056a00125000b004e1e36d4428sm13219848pfi.104.2022.02.28.05.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:37:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     mingo@redhat.com, rostedt@goodmis.org, gregkh@linuxfoundation.org,
        Yu Kuai <yukuai3@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
In-Reply-To: <20220228034354.4047385-1-yukuai3@huawei.com>
References: <20220228034354.4047385-1-yukuai3@huawei.com>
Subject: Re: [PATCH v2] blktrace: fix use after free for struct blk_trace
Message-Id: <164605542062.3958.11033668942703223709.b4-ty@kernel.dk>
Date:   Mon, 28 Feb 2022 06:37:00 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 11:43:54 +0800, Yu Kuai wrote:
> When tracing the whole disk, 'dropped' and 'msg' will be created
> under 'q->debugfs_dir' and 'bt->dir' is NULL, thus blk_trace_free()
> won't remove those files. What's worse, the following UAF can be
> triggered because of accessing stale 'dropped' and 'msg':
> 
> ==================================================================
> BUG: KASAN: use-after-free in blk_dropped_read+0x89/0x100
> Read of size 4 at addr ffff88816912f3d8 by task blktrace/1188
> 
> [...]

Applied, thanks!

[1/1] blktrace: fix use after free for struct blk_trace
      commit: 30939293262eb433c960c4532a0d59c4073b2b84

Best regards,
-- 
Jens Axboe


