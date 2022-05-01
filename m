Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264C3C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 May 2022 17:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352926AbiEAR3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 May 2022 13:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiEAR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:29:36 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B82BE12
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 10:26:10 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso1996862fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=pI+qY9/hirlSNjBDN43HbEPTPB6DnELjIcqxHY4iYSM=;
        b=lEmg2o4Jcwec6tRJGHz/2fgZaeertWvBPVzXVQ70FoParo6dqwW7L3sMzmqIrisHG9
         45JSmVzOLJhGM/2braFZ0LvfTaq8p00M7V4jQ2YxtvKo9RtScTieJCvaJE3jvGmQKnq+
         kowSRNHp4D9VAVj6ieVbif0N2SvCvAGyzV/Rl8q9DAJoKC80W37L22mRra1/iZn5bWiV
         +EYjstV1UEoZuJNHQ8z6Ww07ohOHT5YA9FIky0znIWk2t99sN41dmQAzXiIR/wZ9/u0q
         OIrNL9CbOe4ih9n3MQ/gx5YL0uLoy2O3QgILH8gMsMdjedLm6Tym4nPXagf7qbhr0tAK
         KNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :from:subject:to:cc:content-language:content-transfer-encoding;
        bh=pI+qY9/hirlSNjBDN43HbEPTPB6DnELjIcqxHY4iYSM=;
        b=eGdO0ZsQRiO+EsMoZBu2yVTPqJ27S5YYav3Poo10Ad37i4ecHrXbLTiACFnaZBEZj/
         lhXENO8I7tOTcS1OER61vaI38kQeY2K4WAKSLZOdlNuWgfH8WApA/yxXH6XvajNku3hZ
         seef8dkYq/IOzMrTR+/hUkoG4TjbpEWrkWG3wcbGesFrg1VOR54c3YvpUZmVy1gCCfDV
         2+M4YLmmnJ4UxPe3wn/xsNp86YQ7sLtpgiG4dVDzy+jgJrnEahtVIrzfzdak4MVOAQL4
         eWhLjTCiKtVtg7NArfWzhywGRoc44jvj0e7X4S2Ogog8iXNC3eAMQLi4Tf+fO2vJk3r5
         Vesg==
X-Gm-Message-State: AOAM532ntkS28R+iJ+wS12edM4U3AS+vnxgoDJbIHAyFBIyu1mCq9+Wj
        KT8KLCiF7TVug5Kx7ixrOtmElux0rEsiEg==
X-Google-Smtp-Source: ABdhPJzs7W3+fcYn/a9QX4d78CRazvy9tcpwS72hZ2BRJr7wqLCWwclb2QsAIF2KVakLF6IXvNZGFQ==
X-Received: by 2002:a05:6871:112:b0:ec:f449:5af8 with SMTP id y18-20020a056871011200b000ecf4495af8mr2991414oab.76.1651425969776;
        Sun, 01 May 2022 10:26:09 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id l2-20020a4ad9c2000000b0035eb4e5a6b7sm3066960oou.13.2022.05.01.10.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 10:26:09 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <7f01221d-f693-adf8-f5a5-d71944b44162@lwfinger.net>
Date:   Sun, 1 May 2022 12:26:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Changes in kernel 5.18-rc1 leads to crashes in VirtualBox Virtual
 Machines
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason,

I maintain VirtualBox for openSUSE. When kernel 5.18-rc1 was released, I fixed 
the usual set of API changes needed to compile the external kernel modules for 
VB. Despite a clean compile, I am still getting random crashes in the VMs. For 
Linux instances, the desktop disappears, but for Windows guests, the VM crashes 
with unhandled kernel exceptions. As I have no experience tracing such crashes, 
I decided to bisect the kernel to find the commit that started these problems.

Surprisingly, the bisection pointed to commit 6e8ec2552c7d ("random: use 
computational hash for entropy extraction"). I am very sure of the bisection as 
the kernel built from the commit that immediately precedes this one, 
cfb92440ee71 - a tag commit by Linus, runs correctly.

Note that I do not believe there is anything wrong with your changes to the 
random number generators. It seems to be a problem with the way the emulator is 
accessing them. The VirtualBox code is quite complicated, and I am no expert 
with C++.

Are there changes that would be required to the X86_64 emulator's access to the 
random number code as a result of your changes? I have found places where the 
emulator accesses /dev/urandom or /dev/random. There are also places that use 
the rdrand and reseed instructions.

Thanks for reading this,

Larry
