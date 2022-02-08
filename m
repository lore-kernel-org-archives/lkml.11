Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B109C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 18:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385446AbiBHSsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 13:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385468AbiBHSsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:48:15 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6A0C061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:48:15 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id t9so94161plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bIoZDesM5AyInsr4M1gx9YJxvXmEwtTsATISevIQ9SU=;
        b=qQiR5qxJuRA5CHx4cFWS46nKdM8jpZCQvszdI2IncKWnPwnDHAm8h6j/uok/XZmlRf
         riuuvVHmGez4GJmvigyCtXadcHIMNSV4Pos0X8xQ8rSmBjlDpXQ6JvnhrL6u3fwWgrM7
         ZzblNZiiW9Gvei/wUV/f2QDOoZteo47tbS976stIw9GHG9qGOSU4WkBhvPzq9NpBXrVm
         r68NCiQqNCgJaoYwmY23hhrek44kM6mqrjFmQ3wgvrGB389TZ1HXJUdxfdfU5zgX4vye
         hDSMXH4bb+6Ld/JssYJZeTuRZn4/T46s8NHbmwAKnGDUYJAFUS6xTSh5V9dY0JpGaLs7
         zAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bIoZDesM5AyInsr4M1gx9YJxvXmEwtTsATISevIQ9SU=;
        b=vP5GeNOlCQdAgBv28Keq9C5snPXUTSWDPR+H1aKeOA9H0MzO/nPM84mhhowPrbSOMY
         nrf/++ntg6TUIl9sz6mKkGWSfcKQ3M6k7ZNnaglIdNOo/4iMIc3w8lKIxz2rpsSvACJs
         rVUTpQ9WyxcZUcYKCFKa2W5eJQyQeKvMMnyrIdIOlP3LxK6CN+UGxEitCCgNhIapa/1f
         ob4FqFJCMhOzXEJVk/QSAz0cDIp5++6Ir2F1mRhHDYtamGQVeah6PMx7YJvueQ0bzz8f
         0H/UgzyC3RmvKyOO+s+2jhaASi1BMjfe3hJqgZ9FwImLqTNUWKmmZgvLKQN+m9bsS9BJ
         QXiw==
X-Gm-Message-State: AOAM531H0s3Bz7UPrL/a5XOgsdEi3wHWjurIe3UMNj7z6w8gviDmoLGx
        RbtR/VKrQTZyPRhWErLDksc=
X-Google-Smtp-Source: ABdhPJwQUJi9CkT9USiF1Y7+qvOezRjjJhU+4/PKcZmsMdaS211UXRoY47JBrVr9kSGJvU6tZJ09eQ==
X-Received: by 2002:a17:90a:7605:: with SMTP id s5mr2849505pjk.194.1644346094692;
        Tue, 08 Feb 2022 10:48:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id r10sm2927084pgk.74.2022.02.08.10.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:48:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 8 Feb 2022 08:48:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 04/12] workqueue: Protect lockdep functions with #ifdef
Message-ID: <YgK67dQabIMam8nc@slm.duckdns.org>
References: <20220208184208.79303-1-namhyung@kernel.org>
 <20220208184208.79303-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208184208.79303-5-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 10:42:00AM -0800, Namhyung Kim wrote:
> With upcoming lock tracepoints config, it'd define some of lockdep
> functions without enabling CONFIG_LOCKDEP actually.  The existing code
> assumes those functions will be removed by the preprocessor but it's
> not the case anymore.  Let's protect the code with #ifdef's explicitly.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Can you wrap them in inlines and add some comment?

Thanks.

-- 
tejun
