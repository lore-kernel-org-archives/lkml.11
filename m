Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE65EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 21:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiEQVxH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 17:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiEQVxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:53:00 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FED5159F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:52:59 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v10so393967pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qTq76WexBV0JNyRRFUKu1P5KggbbCHsuVBAPQSD8ruw=;
        b=WKfDVvhKWDSZfPwR0R3nD6JkuqRrEYYVJ/NT1Nz5iBgc5Y3lkZv4Po6hC5icvlkZ2P
         6W+u7wffkTAUNO/7GndZ2Kpd5+Pnsqqk/YJ+dDPXGtWsgc+yVxpoHpYX/oj+b+hojB/m
         fe8gcoVa/DhqnThJ075JV4mbj/8RwTs39NCC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qTq76WexBV0JNyRRFUKu1P5KggbbCHsuVBAPQSD8ruw=;
        b=t6e5Gu3oM9N0O+Bx8Yp46ti6PfnluCXwHzefLhzeFaoe5uaL3atM+aBprzWzVEVT3t
         sUzHahp9lXpuZe7fHi7nffZyBRVfKfu8jKDcjeh6JLkEzg462BDfIY8zPdlpOLfMSOeH
         0ZJIYtxT3dB3h0NZVkn2rSiA0/vGvMVbWvD1xIijw8Qpq0AwDiGVw+/6IBzWGELOTPiy
         M6eBDDP5n4DAQzAAFaG16KXpQyA2MpXqpxe1Jkx2F1iAb8+cSq7ZwgKD+8kQtDHFavNN
         woDnGeat585eoKPI4wW9GgKb8+yPIwuGsaTwO5MBo+izFyDLFKUvZ6OlExrPyQiowq0a
         2g4A==
X-Gm-Message-State: AOAM533ZCIuZjn/Q4jMNJpxMXaK0UFk4SzRNq4xTJzDL1WP32nAKdRao
        iyELk3pGRv0sh/YJ7pA7YLOEChQk4o/o3Q==
X-Google-Smtp-Source: ABdhPJxk4MDeCaMJr0rnFLcT0JlYl4qymEx4H2CwxmdDPMOBrKp45ToZgHDIYqghYn9z/XgRGpnSPw==
X-Received: by 2002:a65:5c48:0:b0:382:2c7:28e9 with SMTP id v8-20020a655c48000000b0038202c728e9mr21494730pgr.472.1652824379139;
        Tue, 17 May 2022 14:52:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709026e0200b00161455d8029sm113731plk.12.2022.05.17.14.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:52:58 -0700 (PDT)
Date:   Tue, 17 May 2022 14:52:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [GIT PULL] lkdtm updates for -next
Message-ID: <202205171451.EE8E27685@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull these lkdtm updates for -next (preferably for the coming
merge window).

Thanks!

-Kees

The following changes since commit 2a0338769f27a38b5dd60b6bef5b83003789439b:

  lkdtm: cfi: Fix type width for masking PAC bits (2022-04-26 17:11:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/lkdtm-next

for you to fetch changes up to f260fd59e3f387432bda51072fff4494fba10b91:

  lkdtm/heap: Hide allocation size from -Warray-bounds (2022-05-17 14:47:08 -0700)

----------------------------------------------------------------
lkdtm updates for -next

- Test for new usercopy memory regions
- avoid GCC 12 warnings
- update expected CONFIGs for selftests

----------------------------------------------------------------
Kees Cook (3):
      lkdtm/usercopy: Rename "heap" to "slab"
      lkdtm/usercopy: Check vmalloc and >0-order folios
      lkdtm/heap: Hide allocation size from -Warray-bounds

Muhammad Usama Anjum (1):
      selftests/lkdtm: Add configs for stackleak and "after free" tests

 drivers/misc/lkdtm/heap.c               |   1 +
 drivers/misc/lkdtm/usercopy.c           | 113 +++++++++++++++++++++++++++-----
 tools/testing/selftests/lkdtm/config    |   2 +
 tools/testing/selftests/lkdtm/tests.txt |   8 +--
 4 files changed, 105 insertions(+), 19 deletions(-)

-- 
Kees Cook
