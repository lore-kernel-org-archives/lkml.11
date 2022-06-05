Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF378CCA47B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 06:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbiFEGbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 02:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbiFEGbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 02:31:10 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9C835ABF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 23:31:08 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id B62E42E2DAF;
        Sun,  5 Jun 2022 08:31:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654410666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7mR/uhtcu+bQbRRFVDfpJIvch/5LDs7zrxCti3YIRI=;
        b=NNf4nXrz2vtZ977c56YRXfFXf59dbJehQHAprCMAaUirsFDhqDZZUzt9bw2q44GncYRyC4
        h8nHEGrQfzlRfdkLmrzIGRDa+xlxLgbbxO9FaY3oAgnqA3lAkmSZnj6Sd1eO5onTPL1VSx
        j/6lmaUlaVBuuIZVrchAMoXTSjcWa6+C1TBdAzekzcrupMsI4FIKet91oHWZYPxw2UpHDE
        qu30kLZOab7h/wJS3zffIINgrkEA8lUxSZYDnwn3DrGqVgY/xRzb5dZ38RiNJm/EmI11Vh
        Y8DoWPV3kgqXs7rCGFMWFbSd+dQenjC9IqTcAn9mi/BIf2GzFU90rWdh6wZE0w==
Message-ID: <dd20ac398f85c6633a1f1e0d1df9249567c5a81d.camel@svanheule.net>
Subject: Re: [PATCH v3 2/4] lib/test: Introduce cpumask KUnit test suite
From:   Sander Vanheule <sander@svanheule.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Sun, 05 Jun 2022 08:31:05 +0200
In-Reply-To: <8b60c0d5add21b43dd75e92d48f2df011f63c6bf.1654410109.git.sander@svanheule.net>
References: <cover.1654410109.git.sander@svanheule.net>
         <8b60c0d5add21b43dd75e92d48f2df011f63c6bf.1654410109.git.sander@svanheule.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-06-05 at 08:22 +0200, Sander Vanheule wrote:
> Add a basic suite of tests for cpumask, providing some tests for empty
> and completely filled cpumasks.
>=20
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
> +static void test_cpumask_iterators(struct kunit *test)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0EXPECT_FOR_EACH_CPU_EQ(test, &=
mask_empty);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0EXPECT_FOR_EACH_CPU_NOT_EQ(tes=
t, &mask_empty);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0EXPECT_FOR_EACH_CPU_WRAP_EQ(te=
st, &mask_empty);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0EXPECT_FOR_EACH_CPU_EQ(test, &=
mask_empty);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0EXPECT_FOR_EACH_CPU_NOT_EQ(tes=
t, &mask_empty);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0EXPECT_FOR_EACH_CPU_WRAP_EQ(te=
st, &mask_empty);

This should be one block of &mask_empty, and one block of cpu_possible_mask=
. I'll fix this in v4
with other comments, or send an update tomorrow.

Best,
Sander

