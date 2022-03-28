Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6308EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 12:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242562AbiC1MiJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 08:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240930AbiC1MiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:38:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD45DEE7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:36:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u22so12494893pfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=s0MYHADlhkLmgL7QL3wLWNFZxF39wct7bEmjjdPPikg=;
        b=vwhmFpraliyqWJSMmnH7DqX9kzpnwRglbGpcow2Z6N0VlX0C05na9yy3Tn5BZcbmQi
         jZQxyUXXeD5bXMcwO10yxyojC0xk+hpMbERx7o7HF9m9cLGsk1x+BTaryp/zJnaudLYL
         8pmtJAIa7I9FHBGI6/YsbQUM0ftJmJNvAE1v6V9gaMgEVuVVMlFgdxnRQWIpdJBdb8Qk
         P71NwacXU98ms1gMdzlFqnrPtydU7m9zsYTYTXNKs52rGcWc90OHNnuDioz4nV1He4wK
         cKRdFdNR9CwAYOSY6Jm15FNAUI+v6bapUwl88hQtcTxyO7V7KBJzk7bqPhTfDeF26HMI
         9Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=s0MYHADlhkLmgL7QL3wLWNFZxF39wct7bEmjjdPPikg=;
        b=GdyHh/5a0bW51wCM5EXii2rJthadUoktUaZF8YTCZgFTomz3648I3+PgToPMmzBF35
         AbbKrbi6eqfMGKB2P+xj2d+5xnA7mwl9wB1PTsuKO+FmMvmEwnbBuqP/b9QtLvjsjSP6
         fKTzEhzrZAn1nrOwTAh6euAWz7Nbn6kakXkOxCi3+r6VAMifVbnmRdrx47mpfBu+eUpj
         6S9SxlePPUOeqfJPyoKbWPewlKNRGK0IBcQVjrrefWRqEnVu11NPYEyGQd55KCDnerk5
         TT2CBrfy+v9dbcyJ2W27a9SZrFRmL1WKncJabRj7pUUknGx1QeLfmsR/wNp/FeiION/W
         3jZg==
X-Gm-Message-State: AOAM531aFVRHXLoLSm55rKGn8b0hWYlAmaRUmfA4W72rlJY/2Jkr8O/d
        bfn1Yx6epb3kNn6JcXSqM5Ta7w==
X-Google-Smtp-Source: ABdhPJzWhjK5YmHFJh+gdwf2xhaMXvtBHzGIOhwb6sN3mioE4XQobBxt9s/O31BZh77mukjrOCqKdQ==
X-Received: by 2002:a63:1918:0:b0:382:1cfa:eefa with SMTP id z24-20020a631918000000b003821cfaeefamr9999216pgl.510.1648470983267;
        Mon, 28 Mar 2022 05:36:23 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090a6c9000b001c993d935e7sm4914071pjj.56.2022.03.28.05.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 05:36:22 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20220328085928.7899-1-jslaby@suse.cz>
References: <20220328085928.7899-1-jslaby@suse.cz>
Subject: Re: [PATCH] block: restore the old set_task_ioprio() behaviour wrt PF_EXITING
Message-Id: <164847098196.6805.10674643795747634430.b4-ty@kernel.dk>
Date:   Mon, 28 Mar 2022 06:36:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 10:59:28 +0200, Jiri Slaby wrote:
> PF_EXITING tasks were silently ignored before the below commits.
> Continue doing so. Otherwise python-psutil tests fail:
>   ERROR: psutil.tests.test_process.TestProcess.test_zombie_process
>   ----------------------------------------------------------------------
>   Traceback (most recent call last):
>     File "/home/abuild/rpmbuild/BUILD/psutil-5.9.0/build/lib.linux-x86_64-3.9/psutil/_pslinux.py", line 1661, in wrapper
>       return fun(self, *args, **kwargs)
>     File "/home/abuild/rpmbuild/BUILD/psutil-5.9.0/build/lib.linux-x86_64-3.9/psutil/_pslinux.py", line 2133, in ionice_set
>       return cext.proc_ioprio_set(self.pid, ioclass, value)
>   ProcessLookupError: [Errno 3] No such process
> 
> [...]

Applied, thanks!

[1/1] block: restore the old set_task_ioprio() behaviour wrt PF_EXITING
      commit: 15583a563cd5a7358e975599b7de7caacd9e9ce9

Best regards,
-- 
Jens Axboe


