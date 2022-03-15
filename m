Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C39C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 18:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350884AbiCOSBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 14:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350861AbiCOSBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:01:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CED659A6D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:00:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u10so30238138wra.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=l3MXoKEOYNqbj2rQ/N3Ogy/kqKRo5wc1bR+B02SiC7k=;
        b=D2k50Loa48l6aPLwLn/ltBMwCMqTISYNTnM9B0ojlGWKnPQ4J+xK25tl8DW1EQfQNf
         yhsnIR0lz3yEDD6kZyqxs8/6O1k3vWweUOr6109EgJIzK2kQrmDvguoMstwgxx3Uy5lf
         HYopNzSccCNub71gngvSIrec9YQDiewfxL/n4EVHdHVpWp/IMq+B61P5P/l+w58dKR8t
         4MvRPWf+dEMCKMsVOUEw7OIE7sUs8i3iEfoEeTRW8KFFgBe89qHG33/tjLE2REAC+EWY
         hg6wgCZkYHWF1zmGDPTFthB+JsL2dUEMwjMR/ca6FqLEXKuSNmGkVJpodcOFr6CM9XyK
         JlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=l3MXoKEOYNqbj2rQ/N3Ogy/kqKRo5wc1bR+B02SiC7k=;
        b=60qecc3FZl/jsKxf60HUtglqosiKkNDiZr4AUydPU1tq/sUjt5D49b3quoaY8y0cHA
         NzjmOZQ6JWcVxFDUwwO7USW8cU7yN+6DXhSmW+tOhe4O8LkbWrJdhC9fqMfsqIb3ZIUz
         F13Ky8XbS2h9VCJ13QaVVMA6m9IYEG4YArXMPxKrd+599h50JmjCNFcISZcLq4WebZNl
         BSE5MXLmKmc+w3U+hP8Xg/msAzAjO5gfTo3Q0kmGxHv/WoO7CZe3TfP4MfIDYkQBleFx
         wBxCt5ZQtjt2hJzM0il/s46vI/jWZujb39vX/im3Ptgs0GIX4fcgWhbYryMPZveuvp+O
         zssg==
X-Gm-Message-State: AOAM533IYF1qpTQTJ61OSaMPVIWtWej0WUneEaOomSsciCqehmNr6LdX
        AQVu60yTcwCqo4zm/JMe92HDXQ==
X-Google-Smtp-Source: ABdhPJxTspIEyKaTQIpafHC/PxEmHzjcrx9sd3PcK18nz+T0qpkOxhTp58llOV7mDVlhV5Xo4CJsyA==
X-Received: by 2002:a05:6000:184f:b0:203:7fca:727e with SMTP id c15-20020a056000184f00b002037fca727emr20751839wri.186.1647367230701;
        Tue, 15 Mar 2022 11:00:30 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d49ce000000b001f036a29f42sm15846299wrs.116.2022.03.15.11.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 11:00:30 -0700 (PDT)
Date:   Tue, 15 Mar 2022 19:00:27 +0100
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Synthesize cycle events
Message-ID: <YjDUO6bbyfGw/u0C@google.com>
References: <20220310093844.982656-1-sesse@google.com>
 <586de5fc-858b-2693-1986-5c77e8c0e3d0@intel.com>
 <YiuKAk7SaXP7B7Ee@google.com>
 <ba2c49da-22c5-06ea-e953-82211b953ca8@intel.com>
 <YjBnet2813sEGjZY@google.com>
 <c50bb87d-9fee-c4f9-a350-8729e503e43a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c50bb87d-9fee-c4f9-a350-8729e503e43a@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 01:32:38PM +0200, Adrian Hunter wrote:
>> I think the structure looks good, but I'm not sure about updating
>> e.g. ptq->last_cy_insn_cnt in both functions? Does that make sense?
> It should only be updated in the new intel_pt_synth_cycle_sample().
> intel_pt_synth_instruction_sample() should be unchanged.

Hm, OK. But something definitely changed between my original patch and
your change. (The first patch; I didn't try the last one yet.) With my
patch, I got (on a specific trace, synthing cycles only with perf report
--itrace=y0nse):

Samples: 4M of event 'cycles:uH', Event count (approx.): 4844309

With yours on the same file:

Samples: 2M of event 'cycles:uH', Event count (approx.): 77622449

The relative times between functions are also pretty different (although
none of them are obviously crazy), so one of them has to be wrong.
Is this to be expected, ie., would you expect your change to fix some
bad bug on cycle-only synth? For reference, “perf script --itrace=i0ns
-F +ipc | grep -c IPC:” (a quick proxy for the number of CYC packets :-) )
yields 4836782, so I'm a bit surprised why there are only 2M events
being emitted from that.

/* Steinar */
